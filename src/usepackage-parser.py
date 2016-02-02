#!/usr/bin/env python3

__author__ = 'Jeff Stafford'

import os, sys, re, getopt

class Entry:
    id = ''
    name = ''
    pointsTo = None  # for entries that are simply pointers to the current version
    version = ''

    def __init__(self, id, name, version, pointsTo):
        self.id = id
        self.name = name
        self.version = version
        self.pointsTo = pointsTo

    '''
    Get the id of what the entry actually points to
    '''
    def getEntry(self):
        entry = ''
        if self.pointsTo is None:
            return self.pointsTo
        else:
            return self.id

class ConfParser:
    entries = {}

    def __init__(self, filename):
        self.readConf(filename)

    '''
    Parse a file and add all usepackage entries to the entries[] dict.
    '''
    def readConf(self, filename):
        # detect if valid file
        if not os.path.isfile(filename):
            sys.exit('Invalid filename.')

        # get regexps compiled to parse apart entries
        id_rexp = re.compile('[\w+-._]')
        name_rexp = re.compile('".*"')
        ver_rexp = re.compile('[0-9]*\.*')
        pointer_rexp = re.compile('<=\s*[^\s]+')

        with open(filename) as file:
            for line in file:

                if (line[0] == '>'):
                    # this is a header for an entry
                    entr_id = id_rexp.findall(line)[0]
                    entr_name = str(name_rexp.findall(line)[0])
                    entr_ver = ver_rexp.findall(line)[0]

                    # check if we already have an entry for this, if not, create one
                    if entr_id in self.entries:
                        entry = self.entries[entr_id]
                        entry.name = entr_name[1:(len(entr_name) - 2)]
                        entry.version = entr_ver
                    else:
                        self.entries[entr_id] = Entry(entr_id, entr_name[1:(len(entr_name) - 2)], entr_ver, None)

                elif line[0].isalnum():
                    # this is an entry
                    entr_id = id_rexp.findall(line)[0]
                    # check if we already have an entry for this guy
                    if entr_id in self.entries:
                        entry = self.entries[entr_id]
                    else:
                        self.entries[entr_id] = Entry(entr_id, None, ver_rexp.findall(line)[0], None)

                    if pointer_rexp.search(line) is None:
                        # its a pointer
                        entry.pointsTo = pointer_rexp.findall(line)[0]
        return

    '''
    Dump entries to csv
    '''
    def writeToCsv(self):
        with open('entries.csv', 'w') as csv:
            csv.write('id,name,version,pointsTo\n')
            for key in sorted(self.entries.keys()):
                entry = self.entries[key]
                csv.write(entry.id + ',' + str(entry.name) + ',' + entry.version + ',' + str(entry.pointsTo) + '\n')
        return

def main(argv):
    conf = ConfParser(argv[1])
    conf.writeToCsv()

if __name__ == '__main__':
    main(sys.argv)
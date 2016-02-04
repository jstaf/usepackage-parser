#!/usr/bin/env python3

import os, sys, re

__author__ = 'Jeff Stafford'


class Entry:
    id = ''
    name = ''
    pointsTo = None  # for entries that are simply pointers to the current version
    usage = ''

    def __init__(self, id, name, pointsTo):
        self.id = id
        self.name = name
        self.pointsTo = pointsTo


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
        id_rexp = re.compile('[\w+-._]+')
        name_rexp = re.compile('".*"')
        pointer_rexp = re.compile('<=\s*[^\s]+')

        with open(filename) as file:
            for line in file:

                if (line[0] == '>'):
                    # this is a header for an entry
                    entr_id = id_rexp.findall(line)[0]
                    entr_name = str(name_rexp.findall(line)[0])

                    # check if we already have an entry for this, if not, create one
                    if entr_id in self.entries:
                        entry = self.entries[entr_id]
                        entry.name = entr_name[1:(len(entr_name) - 1)]
                        if entry.name == '': entry.name = entry.id
                    else:
                        entry = Entry(entr_id, entr_name[1:(len(entr_name) - 1)], None)
                        if entry.name == '': entry.name = entry.id
                        self.entries[entr_id] = entry

                elif line[0].isalnum():
                    # this is an entry
                    entr_id = id_rexp.findall(line)[0]
                    # check if we already have an entry for this guy
                    if entr_id not in self.entries:
                        self.entries[entr_id] = Entry(entr_id, entr_id, None)
                    if pointer_rexp.search(line) is not None:
                        # its a pointer
                        self.entries[entr_id].pointsTo = pointer_rexp.findall(line)[0][2:]

        for key in self.entries.keys():
            self.entries[key].usage = 'use ' + key
        return

    def addEntriesFromTSV(self, filename):
        try:
            with open(filename) as file:
                header = True
                for line in file:
                    if header:
                        header = False
                        continue
                    splat = line.split(sep='\t')
                    newEntry = Entry(splat[0], splat[1], None)
                    newEntry.usage = splat[2][:-1]
                    self.entries[splat[0]] = newEntry
        except:
            sys.exit(filename + ' appears to be incorrectly formatted. Are you using spaces instead of tabs?')
        return

    '''
    Dump entries to csv
    '''
    def writeToTSV(self):
        with open('entries.tsv', 'w') as csv:
            csv.write('id\tname\tpointsTo\tusage\n')
            for key in sorted(self.entries.keys(), key=str.lower):
                entry = self.entries[key]
                pointer = entry.pointsTo
                if pointer is None: pointer = ''
                csv.write(entry.id + '\t' + str(entry.name) + '\t' + pointer + '\t' + entry.usage + '\n')
        return

    def writeWikiTable(self):
        with open('wikitable.txt', 'w') as tab:
            # header
            tab.write('{| class="wikitable" style="text-align: center; \n')
            tab.write('! Software Name / Version !! Package Name !! Points To !! Usage Notes \n')

            # write entries to table
            for key in sorted(self.entries.keys(), key=str.lower):
                entry = self.entries[key]
                pointer = entry.pointsTo
                if pointer is None: pointer = ''
                tab.write('|-\n| ' + entry.name + ' || ' + entry.id + ' || ' + pointer + ' || ' + entry.usage + ' \n')

            # close table
            tab.write('|}')


def main(argv):
    if len(argv) < 2: sys.exit('Usage: usepackage-parser.py </path/to/usepackage.conf> [tsv with other software]')
    conf = ConfParser(argv[1])
    if len(argv) == 3:
        conf.addEntriesFromTSV(argv[2])
    conf.writeWikiTable()

if __name__ == '__main__':
    main(sys.argv)
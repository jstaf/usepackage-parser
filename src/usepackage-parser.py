#!/usr/bin/env python3

__author__ = 'Jeff Stafford'

import os

class Entry:
    id = ''
    name = ''
    pointsTo = None # for entries that are simply pointers to the current version
    version = ''
    path = ''

    def __init__(self, id, name, version, path, pointsTo):
        self.id = id
        if pointsTo is None:
            self.name = name
            self.version = version
            self.path = path
        else:
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

    def __init__(self, filename):
        self.readConf(filename)

    def readConf(self, filename):
        # skeleton of future method
        # read file, create Entry obj for every pointer and entry and add to dict
        return
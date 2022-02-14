"""
    Utilities for use within Validation 
"""
import os
import sys
import xml.etree.ElementTree as ET

def get_raven_loc():
    """
        Return RAVEN location from Validation/.ravenconfig.xml
        @ In, None
        @ Out, loc, string, absolute location of RAVEN
    """
    config = os.path.abspath(os.path.join(os.path.dirname(__file__),'..','.ravenconfig.xml'))
    if not os.path.isfile(config):
        raise IOError('Validation config file not found at "{}"! Has Validation been installed as a plugin in a RAVEN installation?'
                    .format(config))
    loc = ET.parse(config).getroot().find('FrameworkLocation').text
    return loc
#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
"""
    sphinx.ext.mathjax
    ~~~~~~~~~~~~~~~~~~

    Allow `MathJax <http://mathjax.org/>`_ to be used to display math 
    in Sphinx's HTML writer - requires the MathJax JavaScript library
    on your webserver/computer.

    Kevin Dunn, kgdunn@gmail.com, 3-clause BSD license.
    

    For background, installation details and support: 
    
        https://bitbucket.org/kevindunn/sphinx-extension-mathjax

"""
from docutils import nodes
from sphinx.application import ExtensionError
from sphinx.ext.mathbase import setup_math as mathbase_setup

def html_visit_math(self, node):
    self.body.append(self.starttag(node, 'span', '', CLASS='math'))
    self.body.append(self.builder.config.mathjax_inline[0] + \
                     self.encode(node['latex']) +\
                     self.builder.config.mathjax_inline[1] + '</span>')
    raise nodes.SkipNode

def html_visit_displaymath(self, node):
    self.body.append(self.starttag(node, 'div', CLASS='math'))
    if node['nowrap']:
        self.body.append(self.builder.config.mathjax_display[0] + \
                         node['latex'] +\
                         self.builder.config.mathjax_display[1])
        self.body.append('</div>')
        raise nodes.SkipNode

    parts = [prt for prt in node['latex'].split('\n\n') if prt.strip() != '']
    for i, part in enumerate(parts):
        part = self.encode(part)
        if i == 0:
            # necessary to e.g. set the id property correctly
            if node['number']:
                self.body.append('<span class="eqno">(%s)</span>' %
                                 node['number'])
        if '&' in part or '\\\\' in part:
            self.body.append(self.builder.config.mathjax_display[0] + \
                             '\\begin{split}' + part + '\\end{split}' + \
                             self.builder.config.mathjax_display[1])
        else:
            self.body.append(self.builder.config.mathjax_display[0] + part + \
                             self.builder.config.mathjax_display[1])
    self.body.append('</div>\n')
    raise nodes.SkipNode

def builder_inited(app):
    if not app.config.mathjax_path:
        raise ExtensionError('mathjax_path config value must be set for the '
                             'mathjax extension to work')
    app.add_javascript(app.config.mathjax_path)

def setup(app):
    mathbase_setup(app, (html_visit_math, None), (html_visit_displaymath, None))
    app.add_config_value('mathjax_path', '', False)
    app.add_config_value('mathjax_inline', [r'\(', r'\)'], 'html')
    app.add_config_value('mathjax_display', [r'\[', r'\]'], 'html')
    app.connect('builder-inited', builder_inited)


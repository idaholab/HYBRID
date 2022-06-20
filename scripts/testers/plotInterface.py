from matplotlib.figure import Figure
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg, NavigationToolbar2QT as NavigationToolbar
from PyQt5.QtWidgets import (QApplication, QWidget, QMainWindow, QPushButton,
  QListWidget, QListWidgetItem, QHBoxLayout, QVBoxLayout, QLabel, QComboBox, 
  QToolBar, QDialog, QLineEdit, QSplitter, QRadioButton, QCheckBox, QFormLayout, 
  QMessageBox, QTabWidget, QTableWidget, QTableWidgetItem, QHeaderView, QMenuBar, 
  QAction, QGroupBox)
from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QColor
import matplotlib
matplotlib.use('Qt5Agg')
import os
from os.path import exists
import shutil

class Plot(FigureCanvasQTAgg):
  '''
  Defines matplotlib plot information
  '''
  def __init__(self, parent=None, width=5, height=4, dpi=100):
    '''
      Creates a Plot Class object
      @ In, parent, None
      @ In, width, float, width of plot
      @ In, height, float, height of plot
      @ In, dpi, int, resoluation of plot
      @ Out, None
    '''
    self.fig = Figure(figsize=(width, height), dpi=dpi)
    self.axes = self.fig.add_subplot(111)
    super(Plot, self).__init__(self.fig)
    self.fig.tight_layout()
class List(QListWidget):
  '''
  Class used to display and move through list of variables
  '''
  def __init__(self, tests):
    '''
      Creates a list class object
      @ In, test, list of DifferPlot objects, holds all information about test
      @ Out, None
    '''
    super().__init__()
    self.tests = tests
    
  def update(self, currentTest, showVar):
    '''
      Updates the list
      @ In, currentTest, string, name of current test
      @ In, showVar, dict, which variables to show among accepted, rejected
      @ Out, None
    '''
    self.clear()
    test = self.tests[currentTest]
    for var in sorted(test.differVars):
      if test.goldVars[var].accept == None and showVar['neutral']:
        self.addItem(QListWidgetItem(var))
      elif test.goldVars[var].accept == False and showVar['reject']:
        newItem = QListWidgetItem(var)
        newItem.setForeground(QColor('red'))
        self.addItem(newItem)
      elif test.goldVars[var].accept == True and showVar['accept']:
        newItem = QListWidgetItem(var)
        newItem.setForeground(QColor('green'))
        self.addItem(newItem)
              
class ComboBox(QComboBox):
  '''
    Combobox to change throught different tests
  '''
  def __init__(self, tests):
    '''
      Create combobox class object
      @ In, test, list of DifferPlot objects, holds all information about test
      @ Out, None
    '''
    super().__init__()
    self.tests = tests

  def update(self, showVar, showTestsDifferVars):
    '''
      Updates the test combobox
      @ In, showVar, dict, which variables to show among accepted, rejected
      @ In, showTestDiffersVars, bool, whether to show tests with differnt
      variable names
      @ Out, None
    '''
    self.clear()
    for name, test in sorted(self.tests.items()):
      if test.sameVariables or showTestsDifferVars:
        if len(test.differVars):
          for var in test.differVars:
            if test.goldVars[var].accept == None and showVar['neutral']:
              self.addItem(name)
              break
            elif test.goldVars[var].accept == False and showVar['reject']:
              self.addItem(name)
              break
            elif test.goldVars[var].accept == True and showVar['accept']:
              self.addItem(name)
              break

class ToleranceBox(QDialog):
  '''
    Creates a dialog box used to set the tolerance of the comparison and
    select which comparisons to use
  '''
  onClicked = pyqtSignal()
  def __init__(self, tests, parent=None):
    '''
      Creates a ToleranceBox class object
      @ In, tests, list of DifferPlot objects, holds all information about test
      @ In, parent, where to put the box
      @ Out, None
    '''
    super(ToleranceBox, self).__init__(parent)
    self.setWindowTitle('Set Tolerances')
    self.tests = tests
    self.createRadioBtns()
    self.createTestSelect()
    self.createTolForms()
    self.fillTolForms()
    self.addLayout()
        
  def createRadioBtns(self):
    '''
      Creates radio buttons used to determine how simultaneous comparisons
      are combined
      @ In, None
      @ Out, None
    '''
    self.radioHBox = QHBoxLayout()
    self.unionRadio = QRadioButton('Pass one check to pass')
    self.unionRadio.setChecked(True)
    self.intersectionRadio = QRadioButton('Fail one check to fail')
    self.radioHBox.addWidget(self.unionRadio)
    self.radioHBox.addWidget(self.intersectionRadio)

  def createTestSelect(self):
    '''
      Creates the selections to choose which comparions to use
      @ In, None
      @ Out, None
    '''
    self.compLabel = QLabel()
    self.compLabel.setText('Comparisons Applied')
    self.l2Check = QCheckBox("Relative Euclidean Distance (magnitude of difference vector)")
    self.weightedCheck = QCheckBox("Weighted sum of:\n(1 - Normalized Cross-correlation)\nRelative Mean Difference\nRelative Standard Deviation Difference")
    self.maxDiffCheck = QCheckBox("Maximum Relative Difference")

  def createTolForms(self):
    '''
      Creates the forms used to set the tolerances for the comparison
      @ In, None
      @ Out, None
    '''
    self.l2Label = QLabel('Euclidean Distance:')
    self.l2Entry = QLineEdit()
    self.l2Form = QFormLayout()
    self.l2Form.addRow(QLabel('Tolerance'), self.l2Entry)
    self.weightedLabel = QLabel('Weighted Sum:')
    self.meanWeightEntry = QLineEdit()
    self.stdvWeightEntry = QLineEdit()
    self.corrWeightEntry = QLineEdit()
    self.weightedEntry = QLineEdit()
    self.weightedForm = QFormLayout()
    self.weightedForm.addRow(
      QLabel('Mean Difference Weight'), self.meanWeightEntry)
    self.weightedForm.addRow(
      QLabel('St. Deviation Difference Weight'), self.stdvWeightEntry)
    self.weightedForm.addRow(
      QLabel('(1-Normalized Cross-correlation) Weight'), self.corrWeightEntry)
    self.weightedForm.addRow(QLabel('Tolerance'), self.weightedEntry)
    self.maxDiffLabel = QLabel('Maximum Relative Difference:')
    self.maxDiffEntry = QLineEdit()
    self.maxDiffForm = QFormLayout()
    self.maxDiffForm.addRow(QLabel('Tolerance'), self.maxDiffEntry)

  def fillTolForms(self):
    '''
      Fills out the tolerance forms to default settings or to previously
      set settings.
      @ In, None
      @ Out, None
    '''
    for test in self.tests.values():
      if test.loaded:
        self.l2Entry.setText(str(test.tols['l2dist']))
        self.meanWeightEntry.setText(str(test.tols['meanWeight']))
        self.stdvWeightEntry.setText(str(test.tols['stdvWeight']))
        self.corrWeightEntry.setText(str(test.tols['corrWeight']))
        self.weightedEntry.setText(str(test.tols['weighted']))
        self.maxDiffEntry.setText(str(test.tols['maxDiff']))
        break

  def addLayout(self):
    '''
      Adds all the objects to the tolerance box window layout
      @ In, None
      @ Out, None
    '''
    self.ApplyButton = QPushButton('Apply')
    self.ApplyButton.clicked.connect(self.onClicked)
    self.tolLayout = QVBoxLayout()
    self.radioBox = QGroupBox('Inclusivity')
    self.radioBox.setLayout(self.radioHBox)
    self.checksAppliedVBox = QVBoxLayout()
    self.checksAppliedVBox.addWidget(self.l2Check)
    self.checksAppliedVBox.addWidget(self.weightedCheck)
    self.checksAppliedVBox.addWidget(self.maxDiffCheck)
    self.checksAppliedBox = QGroupBox('Checks Applied')
    self.checksAppliedBox.setLayout(self.checksAppliedVBox)
    self.tolLayout.addWidget(self.checksAppliedBox)
    self.tolLayout.addWidget(self.radioBox)
    self.l2VBox = QVBoxLayout()
    self.l2VBox.addLayout(self.l2Form)
    self.l2Box = QGroupBox('Relative Euclidean Distance')
    self.l2Box.setLayout(self.l2VBox)
    self.tolLayout.addWidget(self.l2Box)
    self.weightedVBox = QVBoxLayout()
    self.weightedVBox.addLayout(self.weightedForm)
    self.weightedBox = QGroupBox('Weighted Difference')
    self.weightedBox.setLayout(self.weightedVBox)
    self.tolLayout.addWidget(self.weightedBox)
    self.maxDiffVBox = QVBoxLayout()
    self.maxDiffVBox.addLayout(self.maxDiffForm)
    self.maxDiffBox = QGroupBox('Maximum Relative Difference')      
    self.maxDiffBox.setLayout(self.maxDiffVBox)
    self.tolLayout.addWidget(self.maxDiffBox)
    self.tolLayout.addWidget(self.ApplyButton)
    self.setLayout(self.tolLayout)
        
  def openWin(self):
    '''
      Prepares the window and opens it
      @ In, None
      @ Out, None
    '''
    self.fillTolForms()
    self.exec() 
    
class CreateGoldBox(QDialog):
  '''
    Dialog box used to walk user through creating new gold files
  '''
  def __init__(self, tests, otherTests, parent=None):
    '''
      Creates a CreateGoldBox object
      @ In, tests, list of DifferPlot objects, holds all information about test
      @ In, parent, where the dialog box goes
      @ Out, None
    '''
    super(CreateGoldBox, self).__init__(parent)
    self.tests = tests
    self.otherTests = otherTests
    self.setGeometry(200, 200, 475, 350)
    self.setWindowTitle('Create New Gold Files')
    self.instruct1Label = QLabel('Select tests to create a new gold file:')
    self.layout = QVBoxLayout()
    self.selectAllCheck = QCheckBox('Select all')
    self.layout.addWidget(self.instruct1Label)
    self.testList = QListWidget()
    self.selectAllCheck.stateChanged.connect(self.selectAll)
    self.layout.addWidget(self.selectAllCheck)
    self.layout.addWidget(self.testList)
    self.versionEntry = QLineEdit()
    self.versionForm = QFormLayout()
    self.versionForm.addRow(QLabel('Dymola Version Name'), self.versionEntry)
    self.layout.addLayout(self.versionForm)
    self.createButton = QPushButton('Create New Gold Files')
    self.createButton.clicked.connect(self.createGold)
    self.layout.addWidget(self.createButton)
    self.setLayout(self.layout)
    
  def fillTestList(self):
    '''
      Creates list of checkable items containing names of tests to create
      new gold files for
      @ In, None
      @ Out, None
    '''
    self.overwriteWarning = False
    for name, test in sorted(self.tests.items()):
      if test.loaded:
        itemString = name + ', '
        numRejected = 0
        for var in test.goldVars.values():
          if var.accept == False:
            numRejected += 1
        itemString += '(' + str(numRejected) + ' rejected variables)'
        listItem = QListWidgetItem(itemString)
        listItem.setFlags(listItem.flags() | Qt.ItemIsUserCheckable)
        listItem.setCheckState(Qt.Unchecked)
        self.testList.addItem(listItem)
    for name in self.otherTests['diffVars']:
      itemString = name +  ', (Different variables but common variables identical)'
      listItem = QListWidgetItem(itemString)
      listItem.setFlags(listItem.flags() | Qt.ItemIsUserCheckable)
      listItem.setCheckState(Qt.Unchecked)
      self.testList.addItem(listItem)
    for name in self.otherTests['diffTimes']:
      itemString = name + ', (Output file had nonmatching timesteps)'
      listItem = QListWidgetItem(itemString)
      listItem.setFlags(listItem.flags() | Qt.ItemIsUserCheckable)
      listItem.setCheckState(Qt.Unchecked)
      self.testList.addItem(listItem)

  def selectAll(self):
    '''
      Selects all the test items on the list to create new gold files for
      @ In, None
      @ Out, None
    '''
    if self.selectAllCheck.isChecked():
      for i in range(self.testList.count()):
        self.testList.item(i).setCheckState(Qt.Checked)
        
  def createGold(self):
    '''
      Creates new gold files by moving file from the one generated during
      the test to the gold file
      @ In, None
      @ Out, None
    '''
    if os.path.basename(os.getcwd()) == 'testers':
      hybridPath = os.path.dirname(os.path.dirname(os.getcwd()))
    else:
      hybridPath = os.getcwd()
    self.testsToAdd = []
    for i in range(self.testList.count()):
      if self.testList.item(i).checkState() == Qt.Checked:
        testInfo = {}
        name = self.testList.item(i).text().split(",", 1)[0]
        testDir = os.path.join(hybridPath, 'tests', 'dymola_tests', name)
        testInfo['goldDir'] = os.path.join(testDir, 'gold')
        outFile = list(filter(lambda x: 'mat' in x, os.listdir(testDir)))[0]
        testInfo['outFilePath'] = os.path.join(testDir, outFile)
        if self.versionEntry.text() == '':
          testInfo['newGoldName'] = outFile
        else:
          testInfo['newGoldName'] = outFile.split(".", 1)[0] + '_' + self.versionEntry.text() + '.mat'
        self.testsToAdd.append(testInfo)
        if exists(os.path.join(testInfo['goldDir'], testInfo['newGoldName'])):
          self.overwriteWarning = True
    if not self.overwriteWarning:
      self.moveAndOverwrite()
    else:
      self.warningDialog()
    self.close()  
    
  def warningDialog(self):
    '''
      Creates new dialog box if creating new gold files will overwrite current
      gold files. Gives options on how to proceed.
      @ In, None
      @ Out, None
    '''
    def proceed():
      '''
        Actions to take if proceed option is selected in the warning dialog
        @ In, None
        @ Out, None
      '''
      if overwriteRadio.isChecked():
        self.moveAndOverwrite()
        overwriteBox.close()
      else:
        self.moveAndAppend()
        overwriteBox.close()
        
    overwriteBox = QDialog()
    overwriteBox.setWindowTitle('Overwrite Options')
    layout = QVBoxLayout()
    infoLabel = QLabel("This will overwrite current gold files. How do you wish to proceed?")
    overwriteRadio = QRadioButton('Overwrite')
    overwriteRadio.setChecked(True)
    appendRadio = QRadioButton('Append with _#')
    proceedButton = QPushButton('Proceed')
    proceedButton.clicked.connect(proceed)
    cancelButton = QPushButton('Cancel')
    cancelButton.clicked.connect(lambda: overwriteBox.close())
    layout.addWidget(infoLabel)
    layout.addWidget(overwriteRadio)
    layout.addWidget(appendRadio)
    layout.addWidget(proceedButton)
    layout.addWidget(cancelButton)
    overwriteBox.setLayout(layout)
    overwriteBox.exec()
  
  def moveAndOverwrite(self):
    '''
      Moves test file to gold folder and overwrites any files with the name
      specified for the new gold folder
      @ In, None
      @ Out, None
    '''
    for testInfo in self.testsToAdd:
      dest = os.path.join(testInfo['goldDir'], testInfo['newGoldName'])
      shutil.move(testInfo['outFilePath'], dest)
  
  def moveAndAppend(self):
    '''
      Moves test file to gold folder. If the name for the new file is the same
      as an existing gold folder, it appends the name with _#
      @ In, None
      @ Out, None
    '''
    for testInfo in self.testsToAdd:
      i = 0
      while True:
        i += 1
        updatedName = testInfo['newGoldName'].split(".", 1)[0] + '_' + str(i) + '.mat'
        dest = os.path.join(testInfo['goldDir'], updatedName)
        if not exists(dest):
          shutil.move(testInfo['outFilePath'], dest)
          break
        
  def openWin(self):
    '''
      Prepares the create gold dialog box and opens it
      @ In, None
      @ Out, None
    '''
    self.testList.clear()
    self.fillTestList()
    self.exec()
    
class MainWindow(QMainWindow):
  '''
    The main window where the plots are shown
  '''
  def __init__(self, tests, otherTests):
    '''
      Creates the main window object where the plots are shown
      @ In, tests, list of DifferPlot objects, holds all information about test
      @ Out, None
    '''
    super().__init__()
    self.tests = tests
    self.otherTests = otherTests
    self.mainWidg = QWidget()
    self.setWindowTitle("Results Differences")
    self.setGeometry(200, 200, 800, 550)
    self.showTestsDifferVars = False
    self.createToolBar()
    self.createMenu()
    self.plot = Plot(self, width=5, height=4, dpi=100)
    self.plotToolbar = NavigationToolbar(self.plot, self)
    self.table = QTableWidget()
    self.table.horizontalHeader().setStretchLastSection(True)
    self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
    self.copyToClipButton = QPushButton('Copy to Clipboard')
    self.copyToClipButton.clicked.connect(self.copyToClip)
    self.combobox = ComboBox(self.tests)
    self.combobox.currentIndexChanged.connect(self.changeTest)
    self.label = QLabel()
    self.label.setWordWrap(True)
    self.varList = List(self.tests)
    self.varList.currentRowChanged.connect(self.selectRow)
    self.acceptButton = QPushButton('Accept')
    self.acceptButton.setStyleSheet('background-color: green')
    self.rejectButton = QPushButton('Reject')
    self.rejectButton.setStyleSheet('background-color: red')
    self.resetButton = QPushButton('Reset')
    self.acceptButton.clicked.connect(self.accept)
    self.rejectButton.clicked.connect(self.reject)
    self.resetButton.clicked.connect(self.resetSingle)
    self.layout = QSplitter()
    self.addLayout()
    self.tolBox = ToleranceBox(tests)
    self.createGoldBox = CreateGoldBox(tests, otherTests)
    self.tolBox.onClicked.connect(self.changeTol)
    self.changeTolButton.clicked.connect(lambda: self.tolBox.openWin())
    self.newGoldAction.triggered.connect(lambda: self.createGoldBox.openWin())
    self.changePosition()
    
  def createToolBar(self):
    '''
      Creates the toolbar for the main window
      @ In, None
      @ Out, None
    '''
    self.toolBar = QToolBar()
    self.changeTolButton = QPushButton('Change Tolerance')
    self.showNeutralCheck = QCheckBox('Show Neutral')
    self.showAcceptedCheck = QCheckBox('Show Accepted')
    self.showRejectedCheck = QCheckBox('Show Rejected')
    self.showNeutralCheck.setChecked(True)
    self.showVar = {
      'neutral': True,
      'accept': False,
      'reject': False
      }
    self.showNeutralCheck.stateChanged.connect(self.changeHidden)
    self.showAcceptedCheck.stateChanged.connect(self.changeHidden)
    self.showRejectedCheck.stateChanged.connect(self.changeHidden)
    self.resetAllButton = QPushButton('Reset All')
    self.resetAllButton.clicked.connect(self.resetDialog)
    self.toolBar.addWidget(self.showAcceptedCheck)
    self.toolBar.addWidget(self.showRejectedCheck)
    self.toolBar.addWidget(self.showNeutralCheck)
    self.addToolBar(self.toolBar)
    
  def createMenu(self):
    '''
      Creates the menu for the main window
      @ In, None
      @ Out, None
    '''
    topMenu = QMenuBar()
    optionsMenu = topMenu.addMenu('Options')
    changeTolAction = QAction('Change Tolerance', self)
    changeTolAction.triggered.connect(lambda: self.tolBox.openWin())
    resetAction = QAction('Reset All Variables', self)
    resetAction.triggered.connect(self.resetDialog)
    self.showChangedModelsAction = QAction(
      'Show tests where variable names differ', self)
    self.showChangedModelsAction.setCheckable(True)
    self.showChangedModelsAction.triggered.connect(self.showVarNameDiff)
    self.newGoldAction = QAction('Create New Gold Files', self)
    optionsMenu.addActions(
      [changeTolAction, resetAction, self.showChangedModelsAction, self.newGoldAction])
    self.setMenuBar(topMenu)
      
  def showVarNameDiff(self):
    '''
      Runs when the menu option is selected to show or unshow
      tests with different variable names. Hides or shows tests accordingly
      @ In, None
      @ Out, None
    '''
    self.showTestsDifferVars = self.showChangedModelsAction.isChecked()
    self.changePosition()
      
  def copyToClip(self):
    '''
      Copies the contents of the table in a way that it will be pastable
      in excel.
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      timeData = currentTest.timeStepsArraygold[0]
      testData = currentTest.testVars[self.varList.currentItem().text()].timeSeries
      refData = currentTest.goldVars[self.varList.currentItem().text()].timeSeries
      clipData = 'Time\tTest\tReference\n'
      for vals in zip(timeData, testData, refData):
        clipData = clipData + str(vals[0]) + '\t'
        clipData = clipData + str(vals[1]) + '\t'
        clipData = clipData + str(vals[2]) + '\n'
      clipVals = QApplication.clipboard()
      clipVals.setText(clipData)
        
  def addLayout(self):
    '''
      Adds the layout to the main window
      @ In, None
      @ Out, None
    '''
    rightSideLayout = QVBoxLayout()
    leftSideLayout = QVBoxLayout()
    acceptRejectLayout = QHBoxLayout()
    acceptRejectLayout.addWidget(self.acceptButton)
    acceptRejectLayout.addWidget(self.rejectButton)
    acceptRejectLayout.addWidget(self.resetButton)
    rightSideLayout.addLayout(acceptRejectLayout)
    plotTableTabs = QTabWidget()
    plotTabLayout = QVBoxLayout()
    plotTabLayout.addWidget(self.plot)
    plotTabLayout.addWidget(self.plotToolbar)
    plotTab = QWidget()
    plotTab.setLayout(plotTabLayout)
    tableTabLayout = QVBoxLayout()
    tableTabLayout.addWidget(self.copyToClipButton)
    tableTabLayout.addWidget(self.table)
    tableTab = QWidget()
    tableTab.setLayout(tableTabLayout)
    plotTableTabs.addTab(plotTab, "Plot")
    plotTableTabs.addTab(tableTab, "Table")
    rightSideLayout.addWidget(plotTableTabs)
    leftSideLayout.addWidget(self.combobox)
    leftSideLayout.addWidget(self.varList)
    leftSideLayout.addWidget(self.label)
    self.leftSide = QWidget()
    self.leftSide.setLayout(leftSideLayout)
    self.rightSide = QWidget()
    self.rightSide.setLayout(rightSideLayout)
    self.layout.addWidget(self.leftSide)
    self.layout.addWidget(self.rightSide)
    self.setCentralWidget(self.layout)

  def selectRow(self):
    '''
      Actions taken when a different variable is selected from the list
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      self.updatePlot()
      self.updateTable()
      self.label.setText(self.tests[self.combobox.currentText(
      )].goldVars[self.varList.currentItem().text()].descr)
    else:
      self.plot.axes.cla()
      self.label.setText('')

  def moveRow(self):
    '''
      Moves the variable list selection forward one
      @ In, None
      @ Out, None
    '''
    if self.varList.currentRow() != self.varList.count() - 1:
      self.varList.setCurrentRow(self.varList.currentRow()+1)
    
  def accept(self):
    '''
      Sets the variable as having been accepted and updates the variable
      list accordingly.
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      var = self.varList.currentItem().text()
      currentTest.goldVars[var].accept = True
      if self.showVar['accept']:
        self.varList.currentItem().setForeground(QColor('green'))
        self.moveRow()
      else:
        if self.varList.count() == 1:
          self.varList.blockSignals(True)
          self.combobox.blockSignals(True)
          self.combobox.update(self.showVar, self.showTestsDifferVars)
          if self.combobox.count():
            self.combobox.setCurrentIndex(0)
          self.combobox.blockSignals(False)
          self.varList.blockSignals(False)
          self.changeTest()
        else:
          self.varList.takeItem(self.varList.currentRow())

  def reject(self):
    '''
      Sets the variable as having been rejected and updates the variable
      list accordingly.
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      var = self.varList.currentItem().text()
      currentTest.goldVars[var].accept = False
      if self.showVar['reject']:
        self.varList.currentItem().setForeground(QColor('red'))
        self.moveRow()
      else:
        if self.varList.count() == 1:
          self.varList.blockSignals(True)
          self.combobox.blockSignals(True)
          self.combobox.update(self.showVar, self.showTestsDifferVars)
          if self.combobox.count():
            self.combobox.setCurrentIndex(0)
          self.combobox.blockSignals(False)
          self.varList.blockSignals(False)
          self.changeTest()
        else:
          self.varList.takeItem(self.varList.currentRow())
          
  def resetSingle(self):
    '''
      If a variable has been accepted or rejected, this changes it
      back to a neutral status
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      var = self.varList.currentItem().text()
      currentTest.goldVars[var].accept = None
      self.varList.currentItem().setForeground(QColor('black'))
      self.moveRow()
        
  def resetDialog(self):
    '''
      Creates a dialog box that pops up when a user selects the reset all
      variables selection from the menu.
      @ In, None
      @ Out, None
    '''
    resetBox = QMessageBox()
    resetBox.setText("This will reset all variables back to neutral.\nThis action cannot be undone.\nDo you wish to proceed?")
    resetBox.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
    resetBox.setWindowTitle('Reset All Variables')
    choice = resetBox.exec()
    if choice == resetBox.Ok:
      self.resetAll()
      
  def resetAll(self):
    '''
      Resets all test variables to a neutral status
      @ In, None
      @ Out, None
    '''
    for test in self.tests.values():
      for var in test.commonVars:
        test.goldVars[var].accept = None
    self.changePosition()
    
  def changeHidden(self):
    '''
      Changes which test variables are hidden based on their
      accept/reject/neutral status
      @ In, None
      @ Out, None
    '''
    self.showVar['neutral'] = self.showNeutralCheck.isChecked()
    self.showVar['accept'] = self.showAcceptedCheck.isChecked()
    self.showVar['reject'] = self.showRejectedCheck.isChecked()
    self.changePosition()
        
  def updatePlot(self):
    '''
      Updates the plot to display the current selected test variable
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      time = currentTest.timeStepsArraygold[0]
      testline = currentTest.testVars[self.varList.currentItem().text()].timeSeries
      refline = currentTest.goldVars[self.varList.currentItem().text()].timeSeries
      self.plot.axes.cla()
      self.plot.axes.plot(time, testline)
      self.plot.axes.plot(time, refline, color='red')
      self.plot.axes.set_xlabel('Time (s)')
      self.plot.axes.legend(['Test', 'Reference'], ncol=2, loc='upper center', bbox_to_anchor=(0.5, 1.15))
      self.plot.fig.tight_layout()
    else:
      self.plot.axes.cla()
    self.plot.draw()
    
  def updateTable(self):
    '''
      Updates the table to display the current selected test variable
      @ In, None
      @ Out, None
    '''
    if self.varList.count() and self.combobox.count():
      currentTest = self.tests[self.combobox.currentText()]
      timeData = currentTest.timeStepsArraygold[0]
      testData = currentTest.testVars[self.varList.currentItem().text()].timeSeries
      refData = currentTest.goldVars[self.varList.currentItem().text()].timeSeries
      self.table.clear()
      self.table.setRowCount(len(timeData) + 1)
      self.table.setColumnCount(3)
      self.table.setItem(0,0, QTableWidgetItem('Time'))
      self.table.setItem(0,1, QTableWidgetItem('Test'))
      self.table.setItem(0,2, QTableWidgetItem('Reference'))
      for i, vals in enumerate(zip(timeData, testData, refData)):
        self.table.setItem(i+1,0, QTableWidgetItem(str(vals[0])))
        self.table.setItem(i+1,1, QTableWidgetItem(str(vals[1])))
        self.table.setItem(i+1,2, QTableWidgetItem(str(vals[2])))
    else:
      self.table.clear()
      self.table.setRowCount(0)

  def changeTest(self):
    '''
      Actions taken when the selected test is changed
      @ In, None
      @ Out, None
    '''
    if self.combobox.count():
      self.varList.blockSignals(True)
      currentTest = self.combobox.currentText()
      self.varList.update(currentTest, self.showVar)
      self.varList.blockSignals(False)
      self.varList.setCurrentRow(0)
      self.updatePlot()
      self.updateTable()
    else:
      self.varList.clear()
      self.plot.axes.cla()
      self.plot.draw()
      self.table.clear()
      self.table.setRowCount(0)
      self.table.setColumnCount(0)

  def changeTol(self):
    '''
      Updates the tolerances on the comparisons of the variables
      @ In, None
      @ Out, None
    '''
    tests = self.tests
    if self.tolBox.unionRadio.isChecked():
      isUnion = True
    else:
      isUnion = False
    toCheck = []
    if self.tolBox.l2Check.isChecked():
      toCheck.append('l2Dist')
    if self.tolBox.weightedCheck.isChecked():
      toCheck.append('weighted')
    if self.tolBox.maxDiffCheck.isChecked():
      toCheck.append('maxDiff')
    for test in tests.values():
      if test.loaded:
        if self.tolBox.l2Check.isChecked():
          test.tols['l2dist'] = float(self.tolBox.l2Entry.text())
        if self.tolBox.weightedCheck.isChecked():
          test.tols['meanWeight'] = float(self.tolBox.meanWeightEntry.text())
          test.tols['stdvWeight'] = float(self.tolBox.stdvWeightEntry.text())
          test.tols['corrWeight'] = float(self.tolBox.corrWeightEntry.text())
        if self.tolBox.maxDiffCheck.isChecked():
          test.tols['maxDiff'] = float(self.tolBox.maxDiffEntry.text())
        test.checkTol(toCheck, isUnion)
    self.changePosition()
    self.tolBox.close()
    
  def changePosition(self):
    '''
      Updates the selected list item and test when any settings have been changed
      @ In, None
      @ Out, None
    '''
    self.varList.blockSignals(True)
    self.combobox.blockSignals(True)
    self.combobox.update(self.showVar, self.showTestsDifferVars)
    if self.combobox.count():
      self.combobox.setCurrentIndex(0)
    self.combobox.blockSignals(False)
    self.varList.blockSignals(False)
    self.changeTest()
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
def main():
    ''' Main method that plots the results
    '''
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt
    import os

    # Optionally, change fonts to use LaTeX fonts
    #from matplotlib import rc
    #rc('text', usetex=True)
    #rc('font', family='serif')

    # Read results
    ofr1=Reader(os.path.join("buildingspy", "examples", "dymola", "case1", "PIDHysteresis.mat"), "dymola")
    ofr2=Reader(os.path.join("buildingspy", "examples", "dymola", "case2", "PIDHysteresis.mat"), "dymola")
    (time1, T1) = ofr1.values("cap.T")
    (time1, y1) = ofr1.values("con.y")
    (time2, T2) = ofr2.values("cap.T")
    (time2, y2) = ofr2.values("con.y")

    # Plot figure
    fig = plt.figure()
    ax = fig.add_subplot(211)

    ax.plot(time1/3600, T1-273.15, 'r', label='$T_1$')
    ax.plot(time2/3600, T2-273.15, 'b', label='$T_2$')
    ax.set_xlabel('time [h]')
    ax.set_ylabel('temperature [$^\circ$C]')
    ax.set_xticks(range(25))
    ax.set_xlim([0, 24])
    ax.legend()
    ax.grid(True)

    ax = fig.add_subplot(212)
    ax.plot(time1/3600, y1, 'r', label='$y_1$')
    ax.plot(time2/3600, y2, 'b', label='$y_2$')
    ax.set_xlabel('time [h]')
    ax.set_ylabel('y [-]')
    ax.set_xticks(range(25))
    ax.set_xlim([0, 24])
    ax.legend()
    ax.grid(True)

    # Save figure to file
    plt.savefig('plot.pdf')
    plt.savefig('plot.png')

    # To show the plot on the screen, uncomment the line below
    #plt.show()

# Main function
if __name__ == '__main__':
    main()

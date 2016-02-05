#! /usr/bin/env python
# $Id: demo.py 299 2007-03-30 12:52:17Z mhagger $

# Copyright (C) 1999-2003 Michael Haggerty <mhagger@alum.mit.edu>
#
# This file is licensed under the GNU Lesser General Public License
# (LGPL).  See LICENSE.txt for details.

"""hostutilization.py -- Reads SAR data from host and creates plots.

Run this script by typing 'python hostutilization.py'.  

"""

import argparse
import datetime
import errno
import shlex
import os
import subprocess

from numpy import *

# If the package has been installed correctly, this should work:
import Gnuplot, Gnuplot.funcutils


class hostutil(object):
    def __init__(self, dom, user, host, sysstat_path, dst_dir="."):
        self.dom = dom
        self.user = user
        self.host = host
        self.sysstat_path= sysstat_path
        self.dst_dir = dst_dir
        
        self.sysstat_snippet = "sa" 
        self.sysstat_files = "sysstat-files"
        self.csv_files = "results"

    def download_sysstat_files(self):
        if self.user is not None:
            serverstring = self.user + "@" + self.host + ":" + self.sysstat_path
        else:
            serverstring = self.host + ":" + self.sysstat_path
    
        try:
            os.makedirs(self.dst_dir + "/" + self.host + "/" + self.sysstat_files)
        except OSError as exception:
            if exception.errno != errno.EEXIST:
                raise

        if self.dom == "ALL":
            serverstring = serverstring + "/*"
            print("scp", serverstring, self.dst_dir + "/" + self.host + "/" + self.sysstat_files)
            subprocess.call(["scp", serverstring, self.dst_dir + "/" + self.host + "/" + "/sysstat-files"])
        else:
            for mydom in self.dom.split():
                print("scp", serverstring + "/" + self.sysstat_snippet + mydom, self.dst_dir + "/" + self.host + "/" + self.sysstat_files)
                subprocess.call(["scp", serverstring + "/" + self.sysstat_snippet + mydom, self.dst_dir + "/" + self.host + "/" + self.sysstat-files])
    
    def prep_csv_net(self):
        try:
            os.makedirs(self.dst_dir + "/" + self.csv_files)
        except OSError as exception:
            if exception.errno != errno.EEXIST:
                raise

        if self.dom == "ALL":
            print("ls", self.dst_dir + "/" + self.host + "/" + self.sysstat_files)
            str_dom_tmp = subprocess.check_output(["ls", self.dst_dir + "/" + self.host + "/" + self.sysstat_files])
            my_doms = []
            my_doms_tmp = str_dom_tmp.splitlines()
            for my_dom in my_doms_tmp:
                my_doms.append(my_dom[2:].decode())
        else:
            my_doms = self.dom.split()

        for my_dom in my_doms:
            str_cmd = "/usr/bin/sar -n DEV -f " + self.dst_dir + "/" + self.host + "/" + self.sysstat_files + "/sa" + my_dom
            cmd = shlex.split(str_cmd)
            str_sar_net = subprocess.check_output(cmd)
            for myline in str_sar_net.splitlines():
                print(myline.decode())


def initialize():
    parser = argparse.ArgumentParser()
    parser.add_argument("-H", "--host", required=True, help="Host from which the sysstat info should be collected.") 
    parser.add_argument("-u", "--user", help="User for SSH server connection")
    parser.add_argument("-p", "--path", help="Path where to find sysstat files")
    parser.add_argument("-d", "--days", help="Days of month, for which graphs should be created. \"02 03 31\" or ALL")
    args = parser.parse_args()
   
    if args.days is None:
        d = datetime.date.today()
        DOM = d.strftime('%d')
    else:
        DOM = str(args.days)

    USER = args.user

    if args.path is None:
        PATH = "/var/log/sysstat"
    else:
        PATH = args.path

    HOST = str(args.host)
    my_hostutil = hostutil(DOM, USER, HOST, PATH)
    
    return(my_hostutil)


def demo():
    """Demonstrate the Gnuplot package."""

    # A straightforward use of gnuplot.  The `debug=1' switch is used
    # in these examples so that the commands that are sent to gnuplot
    # are also output on stderr.
    g = Gnuplot.Gnuplot(debug=1)
    g.title('Network Utilization') # (optional)
    g('set style data linespoints') # give gnuplot an arbitrary command
    # Plot a list of (x, y) pairs (tuples or a numpy array would
    # also be OK):
    g.plot([[0,1.1], [1,5.8], [2,3.3], [3,4.2]])
    input('Please press return to continue...\n')

    g.reset()
    # Plot one dataset from an array and one via a gnuplot function;
    # also demonstrate the use of item-specific options:
    x = arange(10, dtype='float_')
    y1 = x**2
    # Notice how this plotitem is created here but used later?  This
    # is convenient if the same dataset has to be plotted multiple
    # times.  It is also more efficient because the data need only be
    # written to a temporary file once.
    d = Gnuplot.Data(x, y1,
                     title='calculated by python',
                     with_='points 3 3')
    g.title('Data can be computed by python or gnuplot')
    g.xlabel('x')
    g.ylabel('x squared')
    # Plot a function alongside the Data PlotItem defined above:
    g.plot(Gnuplot.Func('x**2', title='calculated by gnuplot'), d)
    input('Please press return to continue...\n')

    # Save what we just plotted as a color postscript file.

    # With the enhanced postscript option, it is possible to show `x
    # squared' with a superscript (plus much, much more; see `help set
    # term postscript' in the gnuplot docs).  If your gnuplot doesn't
    # support enhanced mode, set `enhanced=0' below.
    g.ylabel('x^2') # take advantage of enhanced postscript mode
    g.hardcopy('gp_test.ps', enhanced=1, color=1)
    print ('\n******** Saved plot to postscript file "gp_test.ps" ********\n')
    input('Please press return to continue...\n')

    g.reset()
    # Demonstrate a 3-d plot:
    # set up x and y values at which the function will be tabulated:
    x = arange(35)/2.0
    y = arange(30)/10.0 - 1.5
    # Make a 2-d array containing a function of x and y.  First create
    # xm and ym which contain the x and y values in a matrix form that
    # can be `broadcast' into a matrix of the appropriate shape:
    xm = x[:,newaxis]
    ym = y[newaxis,:]
    m = (sin(xm) + 0.1*xm) - ym**2
    g('set parametric')
    g('set style data lines')
    g('set hidden')
    g('set contour base')
    g.title('An example of a surface plot')
    g.xlabel('x')
    g.ylabel('y')
    # The `binary=1' option would cause communication with gnuplot to
    # be in binary format, which is considerably faster and uses less
    # disk space.  (This only works with the splot command due to
    # limitations of gnuplot.)  `binary=1' is the default, but here we
    # disable binary because older versions of gnuplot don't allow
    # binary data.  Change this to `binary=1' (or omit the binary
    # option) to get the advantage of binary format.
    g.splot(Gnuplot.GridData(m,x,y, binary=0))
    input('Please press return to continue...\n')

    # plot another function, but letting GridFunc tabulate its values
    # automatically.  f could also be a lambda or a global function:
    def f(x,y):
        return 1.0 / (1 + 0.01 * x**2 + 0.5 * y**2)

    g.splot(Gnuplot.funcutils.compute_GridData(x,y, f, binary=0))
    input('Please press return to continue...\n')

    # Explicit delete shouldn't be necessary, but if you are having
    # trouble with temporary files being left behind, try uncommenting
    # the following:
    #del g, d


# when executed, just run demo():
if __name__ == '__main__':
    my_hostutil = initialize()
    # my_hostutil.download_sysstat_files()
    my_hostutil.prep_csv_net()
    # demo()


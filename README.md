#!====================================================================================================+!
#! HISTOGRAMMING OF ANY DATA IS NECESSARY FOR THE CALCULATION OF PROBABILTY
#! THE USUAL ALGORITHM OF BINNING/HISTOGRAMMING IS VERY STRAIGHT FORWARD 
#! USING THE FOLLOWING EQUATION : nbin = NINT((gmax - gmin)/grid) + 1
#! gmin = minimum of data ;
#! gmax = maximum of data ;
#! grid = grid size at which the bin or histogram is calculated
#! NOW THE HISTOGRAM IS CALCULATED as : index1 = NINT((cv(i) - gmin)/grid) + 1
#! cv(i) = time series data for which histogramming will be performed
#! THE ABOVE METHOD FAILS IN THE CASE WHERE NEEDS TO COMUPTE THE PROBABILITY IN UNEVEN GRID POINTS
#!
#! I HAVE CREATED A DIFFERENT ALGORITHM TO GET THE HISTOGRAM WHETHER THE GRID IS EVEN OR UNEVEN
#! EACH BIN INDEX HAS A CORRESPONDING POSITION AND IT DOSEN'T MATTER IF THE POSITIONS ARE
#! EVENELY DISTRIBUTED OR ODDLY AND OR EVEN/ODD, THIS ALGORITH WILL WORK FOR ANY CASE
#! 
// WRITTEN BY :: Rahul Verma (vrahul@iitk.ac.in)
#!====================================================================================================+!
#! 

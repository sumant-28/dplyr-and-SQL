# dplyr-and-SQL
The R package dplyr can be used as a replacement to relational database software. The package works on R's native dataframe data type so it is easy to incorporate into a workflow of data preparation to analysis to visualisation. As a demonstration of its usefulness the package is used to answer a sample of the popular sqlzoo problems.

## SELECTbasics/SELECTfromnobel/SELECTfromworld

For questions involving basic select queries dplyr seems to be no worse off than SQL, the syntax is equally straightforward.

## SELECTinSELECT

No file is uploaded, the author is not aware of a method to use nested select statements in dplyr.

## SUMandCOUNT

For select queries that involve the use of aggregate functions the dplyr package can be used to generate the same output as one would obtain using SQL but the code is not as succinct.

## JOIN

In contrast to nested select and aggregate function queries joins are an advanced type of query where the dplyr package appears to be no more difficult than SQL to use.

The final problem shows where SQL is superior to using dplyr in R. When there are multiple aggregate functions and join statements the specialisation in SQL makes R a chore to work with by comparison.

# dplyr-and-SQL
The R package dplyr is described as being a replacement to relational database software that uses SQL to navigate databases. This repository demonstrates how that is the case by using the package while going through the first few examples in sqlzoo.

## SELECTbasics/SELECTfromnobel/SELECTfromworld

For questions involving basic select queries dplyr seems to be no worse off than SQL, the syntax is equally straightforward.

## SELECTinSELECT

No file is uploaded, the author is not aware of a method to use nested select statements in dplyr.

## SUMandCOUNT

For select queries that involve the use of aggregate functions the dplyr package can be used to generate the same output as one would obtain using SQL but the code is not as succinct.

## JOIN

In contrast to nested select and aggregate function queries joins are an advanced type of query where the dplyr package appears to be no more difficult than SQL to use.

The final problem shows where SQL is superior to using dplyr in R. When there are multiple aggregate functions and join statements the specialisation in SQL makes R a chore to work with by comparison.

# Eye catching name for your function

# Issue: A description of what this script/function does, try to be concise yet informative enough that someone 
# can figure out what this does but isn't overwhelmed . 
# Make sure you annotate the code throughout so others can understand what is being done and why!

# Author: Anne O. Minus

# Date: March 14, 1592

############################################################################################################################
# Example implementaiton: Give an example of using your function (if applicable)

# results <- flex.db.query(package ="ROracle", 
#                           SQLtext = "SELECT * FROM marfissci"
#                           un = "yourusernamehere",
#                           pw = "yourpwdhere",
#                           db.con = "yourdbconhere")
# This will open and close your connection the the database automatically in one line, and output your results.
###########################################################################################################################
# Function

# This example function allows you to run a SQL query using either RODBC or ROracle. Who comes up with this stuff!!
flex.db.query <- function(package="RODBC", un=un.ID, pw=pwd.ID, db.con=db.con, SQLtext="SQLtext") {
  
  # Open the channel if using ROracle:
  if(package %in% "ROracle") {
    require(ROracle)
    # Open the channel to the database
    chan <- dbConnect(dbDriver("Oracle"), un, pw, db.con, believeNRows=FALSE)
  }
  
  # Open the channel if using RODBC:
  if(package %in% "RODBC") {
    require(RODBC)
    # Open the channel to the database
    chan <- odbcConnect(uid=un, pwd = pw, dsn=db.con)
  }  
  
  # Run query if using ROracle
  if(package %in% "ROracle") {
    # Run the query and add data to the disc.lst object
    queryresults <- dbGetQuery(chan, SQLtext)
    # close the odbc connection
    dbDisconnect(chan)
  }
  
  # Run query if using ROracle
  if(package %in% "RODBC") {
    # Run the query and add data to the disc.lst object
    queryresults <- sqlQuery(chan, SQLtext)
    # close the odbc connection
    odbcClose(chan)
  }
  
  # return the results as an object
  return(queryresults)
} # end function
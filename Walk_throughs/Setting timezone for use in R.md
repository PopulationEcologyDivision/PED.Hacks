# Setting up Halifax timezone for R

Issue: R has a hard time with timezones because it thinks we're based in Quebec. 

Hack:

**Please read all the way through before proceeding so that you don't unintentionally overwrite your Rprofile**

Step 1
You need to R as an admin. Easiest way to do this is hold down shift+ctrl when you click on the R-icon, the Avecto password thingy should pop up.

Step 2
Check if this is an issue for you
```{r}
# Step 1 Run this, does it say it’s an hour ago?
Sys.time()
# If it does, when you run this I expect it says you are “America/Curacao”
Sys.timezone()
```

Step 3 DFO network (for a computer connected to DFO network)
```{r}
# If it doesn’t say “America/Halifax” in step 2 you should change this, this will force R to think no matter what you are in the world that you are in the same timezone as Halifax
# Run this line to force the computer to be “America/Halifax”, this overwrites your Rprofile.site file so be careful If you have custom stuff in there (See note 1)!!
cat("Sys.setenv(TZ='America/Halifax')",file=file.path(R.home(component="etc"),'Rprofile.site'),sep='\n')
```
--------------------------------------------------
Step 3 Outside DFO (for a computer not on DFO network where Step 2 is an issue)

```{r}
# First you will need to install two packages
install.packages(c(“rgeolocate”,”httr”))
# This then goes and checks where in the world your IP address pings to, this breaks on DFO network as it pings to Quebec
# So this is a nice solution if travelling with a DFO laptop and are working out of non-DFO facilities.
setme <- 
"Sys.setenv(TZ='America/Halifax’) #some default not get any errors
invisible(loadNamespace('rgeolocate'))
invisible(loadNamespace('httr'))
mytz <- rgeolocate::ip_api(httr::content(httr::GET('https://api.ipify.org?format=json'))[1])[['timezone']]
Sys.setenv(TZ=mytz)"
# Now replace your Rprofile.site with the timezone that your IP address says you are in.  this overwrites your Rprofile.site file so be careful If you have custom stuff in there (See note 1)!!
cat(setme,file=file.path(R.home(),'etc/Rprofile.site'),sep='\n')
```

Two things
1.	This overwrites whatever is in the ‘Rprofile.site’ file, so if you have anything important in there you may want to just open that as an admin and add this line to it….  `r Sys.setenv(TZ='America/Halifax')`… I haven’t tested but believe that should work.
2.	If you use an .Rprofile you could also just add this to it… Sys.setenv(TZ='America/Halifax')…  the .Rprofile fix is not as robust as changing the Rprofile.site file according to what I’ve been reading.

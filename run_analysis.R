### Class project for Getting and Cleaning Data
### This file will contain the code for creating a tidey data set.

### Downloading and unzipping the data files
setwd("p://CDP/")
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./zippedData")
unzip("./zippedData",exdir="./EXTFile")
dateDownloaded<-date()

#### Loading files ####
### First loade the training data
XTrain<-read.table("./EXTFile/UCI HAR Dataset/train/X_train.txt", header=FALSE)
yTrain<-read.table("./EXTFile/UCI HAR Dataset/train/y_train.txt", header=FALSE)
SubTrain<-read.table("./EXTFile/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
SYTrain<-cbind(SubTrain,yTrain) #binds the person and the activity

rm(yTrain)
rm(SubTrain)

#YXTrain<-cbind(yTrain,XTrain)###The timing is off for this bind
#SYXTrain<-cbind(SubTrain,YXTrain)###The timing is off for this bind
#The columns in this final data frame start as "subject" "Activity" and then 561 variables of measures.

###Now load the test data
XTest<-read.table("./EXTFile/UCI HAR Dataset/test/X_test.txt", header=FALSE)
YTest<-read.table("./EXTFile/UCI HAR Dataset/test/y_test.txt", header=FALSE)
STest<-read.table("./EXTFile/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
SYTest<-cbind(STest,YTest)#combine the person and activity

rm(YTest)
rm(STest)

#YXTest<-cbind(YTest,XTest)
#SYXTest<-cbind(STest,YXTest)
### This last data frame has the same columns as the SYXTrain data frame. 
#Combine SYXTrain and SYXTest to construct a single data frame.
DTA<-rbind(XTrain,XTest) #stack the data
DTARL<-rbind(SYTrain,SYTest) #stack the people and activities
rm(XTest)
rm(XTrain)
rm(SYTrain)
rm(SYTest)

#### Extract a DF of variable names
vn<-read.table("./EXTFile/UCI HAR Dataset/features.txt",header=FALSE)

###Need to extract the location of the means and standard deviations.

f<-function(x){
    a<-x#use a local vairable
    b<-sub(".*?-(.*?)(-.*|$)","\\1",a)
    if(b=="mean()"){
        T<-TRUE
    }else if(b=="std()"){
        T<-TRUE
    }else{
        T<-FALSE
    }
    return(T)
}

v<-vector()
n<-length(vn[[2]])
for(i in 1:n){
    t<-vn[[2]][[i]]
    t2<-f(t)
    v<-c(v,t2)
}

### Extract columns ###
DTA<-DTA[,v] #This is a data.frame with mean and std measures

###Extract the Variable Names with mean or std within the name. Construct a vector that will be used to give the data frame columns their names

vnp<-vn[v,] #This is a data frame
rm(vn)

### need to coerce vnp column to a vector and then combine with vnames
vn1<-vnp[[2]]
vn1<-as.character(vn1)
vnames<-c("Person_ID","Activity_ID",vn1) #This vector contains the column names for the data frame.
rm(vn1)
rm(vnp)
###another bind
DTA<-cbind(DTARL,DTA)
names(DTA)<-vnames

rm(vnames)
#I now have a data frame with columns representing only means and standard deviations of each of the variables. Each
#Row is labeled with a person and an activity.

#### Give meaningful names to the activities in the data set ###
#Activity;
  #1. Walking
  #2. Walking up Stairs
  #3. Walking downstairs
  #4. Sitting.
  #5. Standing
  #6. Laying

DTA$fActivity<-factor(DTA$Activity_ID)
DTA$fActivity<-factor(DTA$fActivity,levels=c(1,2,3,4,5,6),labels=c("Walking",'Walking_up_stairs',"Walking_Downstairs","Sitting","Standing","Laying"))

head(DTA)

Temp<-aggregate(DTA[,3:68],by=list(DTA$Person_ID,DTA$fActivity),FUN=mean,na.rm=TRUE)
names(Temp)[names(Temp)=="Group.1"]<-"Person_ID"
names(Temp)[names(Temp)=="Group.2"]<-"Activity"

DTA<-Temp
rm(Temp)
write.table(DTA,file="./TidyData.txt",sep=" ", row.name=FALSE)

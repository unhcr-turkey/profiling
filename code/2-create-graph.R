## Generation of a exploratory graphs

## Visual exploration of data will provide a quick overview 

library(plyr)
library(ggplot2)
library(RColorBrewer)
library(directlabels)
library(ggthemes)
###########Likert Analyisis
## http://jason.bryer.org/likert/
#library(devtools)
#install_github('jbryer/likert')
library(likert)
library(reshape)


#display.brewer.all()
# Choose a qualitative color palette with blue and red
#display.brewer.pal(2, 'Set1')
# Warning tells us we need to request 3+ color levels;
# Just save the first two levels: first blue, then red
#cbQualColors = brewer.pal(3, 'Set1')[c(2, 1)]
#cbQualColors # saved as character strings of hex values
# Use a sequential color scheme for the 7 MONTHS values;
# first few are too light, so request more colors and only use later ones
#display.brewer.pal(9, 'YlGn')
#cbSeqColors = brewer.pal(9, 'YlGn')[3:9]


#####################################################################################
### Let's try to generate chart for all variables
#####################################################################################

#print(strtable(data, factor.values=as.integer), na.print='')

data.str <- strtable(data1, factor.values=as.integer)

#################################################

## We will use barplot for select_one variable

## list of field who have multiple predefined values

levels(as.factor(data.str$class))


## extracting unique choice questions
data.class2graph  <- data.str[(data.str$class=="Factor w/ 3 levels" | data.str$class=="Factor w/ 4 levels"| data.str$class=="Factor w/ 5 levels"| 
                        data.str$class=="Factor w/ 6 levels"|  data.str$class=="Factor w/ 7 levels"),]

class2graph <- data.class2graph$variable
data.single <- data1[class2graph]

levels(data.single$Family.Size)

data.single$total <- 1
#data.single$total[data.single$Family.Size=="1"] <- 1 
#data.single$total[data.single$Family.Size=="1 - 3"] <- 3 
#data.single$total[data.single$Family.Size=="4 - 6"] <- 5 
#data.single$total[data.single$Family.Size=="7 and above"] <- 7 

names(data.single)

## Now we can start plotting in a loop
# the key is at the line here
# p + aes_string(x = names(mydata)[i])
# Use aes_string instead of aes, so that when you look at summary(ggplot_obj), 
# the mapping for x-values that are changing will be the actual string and not a variable i.

p <- ggplot(data.frame(data.single), aes(y=data.single$total)) + ylab("# of Responses") + scale_y_continuous(labels=format_si())
for (i in 1:41 ) {
  rm(variablename)
  variablename <- names(data.single)[i]
  rm(plot)
  plot <- p + 
     aes_string(x = names(data.single)[i]) +
   # aes_string(x = reorder( names(data.single)[i], names(data.single)[i], function(x)-length(x)))  +
    xlab(colnames(data.single[i])) + 
    geom_bar( stat="identity",fill="#2a87c8",colour="#2a87c8")  +
    guides(fill=FALSE) + 
    # coord_flip()+
     xlab("") + 
    coord_flip() + 
    ggtitle(variablename)
  assign(paste("plot", variablename, sep=""), plot)
  ggsave(filename=paste("out/plot_",i,variablename,".png",sep=""), plot=plot, width=8, height=6,units="in", dpi=300)
}


## We will use histogram variable for integer variables


###############################################################
## Education                                             #####
###############################################################
data$Education <-factor(data$Education, levels=data[order(data$Education), "Education"])

bar.education <- ggplot(data=data, aes(x=Education)) + 
  geom_bar() +
  # geom_text(aes(label=variable), vjust=0) +
  #guides(fill=FALSE) + 
  coord_flip()+
  #scale_fill_manual(values=c("#56B4E9","#999999", "#E69F00"))+
  #facet_grid( . ~ context ) +
  #scale_y_discrete("Réponse") +
  ylab("Response") + 
  #xlab("Education") +
  theme_tufte()+
  ggtitle("Education")
ggsave("out/education.png", bar.education, width=6, height=4,units="in", dpi=300)



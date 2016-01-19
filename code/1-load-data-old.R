### Load data from Limesurvey
data <- read.table("data/survey_91923_R_data_file.csv", sep=",", quote = "'", na.strings=c("","\"\""), stringsAsFactors=FALSE)

data[, 1] <- as.numeric(data[, 1])
attributes(data)$variable.labels[1] <- "id"
names(data)[1] <- "id"

data[, 2] <- as.character(data[, 2])
attributes(data)$variable.labels[2] <- "submitdate"
names(data)[2] <- "submitdate"

#Field hidden

data[, 3] <- as.character(data[, 3])
attributes(data)$variable.labels[3] <- "startlanguage"
names(data)[3] <- "startlanguage"

data[, 4] <- as.character(data[, 4])
attributes(data)$variable.labels[4] <- "token"
names(data)[4] <- "token"

data[, 5] <- as.character(data[, 5])
attributes(data)$variable.labels[5] <- "Age Group"
data[, 5] <- factor(data[, 5], levels=c("A1","A2","A3","A4","A5"),labels=c("0 - 4","5 - 11","12 - 17","18 - 59","60 +"))
names(data)[5] <- "First Question"

data[, 6] <- as.character(data[, 6])
attributes(data)$variable.labels[6] <- "Sex"
data[, 6] <- factor(data[, 6], levels=c("A1","A2","A3"),labels=c("Kadın","Erkek","Transgender"))
names(data)[6] <- "Second Question"

data[, 7] <- as.character(data[, 7])
attributes(data)$variable.labels[7] <- "Marital Status"
data[, 7] <- factor(data[, 7], levels=c("A1","A2","A3","A4","A5","A6","A7"),labels=c("Single","Married","Widowed","Divorced","With a partner","Separated","Common Law Marriage"))
names(data)[7] <- "Question Three"

data[, 8] <- as.character(data[, 8])
attributes(data)$variable.labels[8] <- "Ethnicity"
names(data)[8] <- "Question 4"

data[, 9] <- as.character(data[, 9])
attributes(data)$variable.labels[9] <- "Religion"
names(data)[9] <- "Question 5"

data[, 10] <- as.character(data[, 10])
attributes(data)$variable.labels[10] <- "Education"
data[, 10] <- factor(data[, 10], levels=c("A1","A2","A3","A4","A5","A6","A7"),labels=c("Informal education","1- 6 years of formal education","7-12 years of formal education","University","Post-University","None","Other"))
names(data)[10] <- "Question 6"

data[, 11] <- as.character(data[, 11])
attributes(data)$variable.labels[11] <- "[Comment] Education"
names(data)[11] <- "Question 6_comment"

data[, 12] <- as.character(data[, 12])
attributes(data)$variable.labels[12] <- "Number of children in the family"
data[, 12] <- factor(data[, 12], levels=c("A1","A2","A3","A4"),labels=c("0","1 - 2","3 - 4","5 or More"))
names(data)[12] <- "Question 7"

data[, 13] <- as.character(data[, 13])
attributes(data)$variable.labels[13] <- "Family Size"
data[, 13] <- factor(data[, 13], levels=c("A1","A2","A3","A4"),labels=c("1","1 - 3","4 - 6","7 and above"))
names(data)[13] <- "Question 8"

data[, 14] <- as.numeric(data[, 14])
attributes(data)$variable.labels[14] <- "[Afghanistan ] Country of Origin"
data[, 14] <- factor(data[, 14], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[14] <- "Question 9_1"

data[, 15] <- as.numeric(data[, 15])
attributes(data)$variable.labels[15] <- "[Azerbaijan ] Country of Origin"
data[, 15] <- factor(data[, 15], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[15] <- "Question 9_2"

data[, 16] <- as.numeric(data[, 16])
attributes(data)$variable.labels[16] <- "[Cameroon ] Country of Origin"
data[, 16] <- factor(data[, 16], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[16] <- "Question 9_3"

data[, 17] <- as.numeric(data[, 17])
attributes(data)$variable.labels[17] <- "[China ] Country of Origin"
data[, 17] <- factor(data[, 17], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[17] <- "Question 9_4"

data[, 18] <- as.numeric(data[, 18])
attributes(data)$variable.labels[18] <- "[Congo ] Country of Origin"
data[, 18] <- factor(data[, 18], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[18] <- "Question 9_5"

data[, 19] <- as.numeric(data[, 19])
attributes(data)$variable.labels[19] <- "[Cote D’Ivoire ] Country of Origin"
data[, 19] <- factor(data[, 19], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[19] <- "Question 9_6"

data[, 20] <- as.numeric(data[, 20])
attributes(data)$variable.labels[20] <- "[Dem. Rep. of Congo ] Country of Origin"
data[, 20] <- factor(data[, 20], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[20] <- "Question 9_7"

data[, 21] <- as.numeric(data[, 21])
attributes(data)$variable.labels[21] <- "[Eritrea ] Country of Origin"
data[, 21] <- factor(data[, 21], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[21] <- "Question 9_8"

data[, 22] <- as.numeric(data[, 22])
attributes(data)$variable.labels[22] <- "[Ethiopia ] Country of Origin"
data[, 22] <- factor(data[, 22], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[22] <- "Question 9_9"

data[, 23] <- as.numeric(data[, 23])
attributes(data)$variable.labels[23] <- "[Iran ] Country of Origin"
data[, 23] <- factor(data[, 23], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[23] <- "Question 9_10"

data[, 24] <- as.numeric(data[, 24])
attributes(data)$variable.labels[24] <- "[Iraq ] Country of Origin"
data[, 24] <- factor(data[, 24], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[24] <- "Question 9_11"

data[, 25] <- as.numeric(data[, 25])
attributes(data)$variable.labels[25] <- "[Uzbekistan ] Country of Origin"
data[, 25] <- factor(data[, 25], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[25] <- "Question 9_12"

data[, 26] <- as.numeric(data[, 26])
attributes(data)$variable.labels[26] <- "[Kyrgyzstan ] Country of Origin"
data[, 26] <- factor(data[, 26], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[26] <- "Question 9_13"

data[, 27] <- as.numeric(data[, 27])
attributes(data)$variable.labels[27] <- "[Liberia ] Country of Origin"
data[, 27] <- factor(data[, 27], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[27] <- "Question 9_14"

data[, 28] <- as.numeric(data[, 28])
attributes(data)$variable.labels[28] <- "[Mauritania ] Country of Origin"
data[, 28] <- factor(data[, 28], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[28] <- "Question 9_15"

data[, 29] <- as.numeric(data[, 29])
attributes(data)$variable.labels[29] <- "[Myanmar ] Country of Origin"
data[, 29] <- factor(data[, 29], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[29] <- "Question 9_16"

data[, 30] <- as.numeric(data[, 30])
attributes(data)$variable.labels[30] <- "[Palestine ] Country of Origin"
data[, 30] <- factor(data[, 30], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[30] <- "Question 9_17"

data[, 31] <- as.numeric(data[, 31])
attributes(data)$variable.labels[31] <- "[Pakistan ] Country of Origin"
data[, 31] <- factor(data[, 31], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[31] <- "Question 9_18"

data[, 32] <- as.numeric(data[, 32])
attributes(data)$variable.labels[32] <- "[Sierra Leone ] Country of Origin"
data[, 32] <- factor(data[, 32], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[32] <- "Question 9_19"

data[, 33] <- as.numeric(data[, 33])
attributes(data)$variable.labels[33] <- "[Somali ] Country of Origin"
data[, 33] <- factor(data[, 33], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[33] <- "Question 9_20"

data[, 34] <- as.numeric(data[, 34])
attributes(data)$variable.labels[34] <- "[Sri Lanka ] Country of Origin"
data[, 34] <- factor(data[, 34], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[34] <- "Question 9_21"

data[, 35] <- as.numeric(data[, 35])
attributes(data)$variable.labels[35] <- "[Sudan ] Country of Origin"
data[, 35] <- factor(data[, 35], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[35] <- "Question 9_22"

data[, 36] <- as.numeric(data[, 36])
attributes(data)$variable.labels[36] <- "[Syria ] Country of Origin"
data[, 36] <- factor(data[, 36], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[36] <- "Question 9_23"

data[, 37] <- as.character(data[, 37])
attributes(data)$variable.labels[37] <- "[Other] Country of Origin"
names(data)[37] <- "Question 9_other"

data[, 38] <- as.numeric(data[, 38])
attributes(data)$variable.labels[38] <- "Which country did you arrive from to Turkey?"
data[, 38] <- factor(data[, 38], levels=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44),labels=c("Afghanistan","Algeria","Angola","Azerbaijan","Bangladesh","Burundi","Cameroon","China","Congo","Cote D’Ivoire","Dem. Rep. of Congo","Dominican Republic","Egypt","Eritrea","Ethiopia","Gabon","Gambia","Guinea","Iran","Iraq","Ivory coast","Jordan","Kyrgyzstan","Lebanon","Liberia","Libya","Mali","Mauritania","Moldova","Morocco","Myanmar","Nigeria","Pakistan","Palestine","Rwanda","Senegal","Sierra Leone","Somali","Sri Lanka","Sudan","Syria","Togo","Uzbekistan","Yemen"))
names(data)[38] <- "Question 10"

data[, 39] <- as.character(data[, 39])
attributes(data)$variable.labels[39] <- "[Other] 
	Which country did you arrive from to Turkey?"
names(data)[39] <- "Question 10_other"

data[, 40] <- as.numeric(data[, 40])
attributes(data)$variable.labels[40] <- "[1 - 30days] 
	How long did you stay in that country? "
data[, 40] <- factor(data[, 40], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[40] <- "Question 11_SQ001"

data[, 41] <- as.numeric(data[, 41])
attributes(data)$variable.labels[41] <- "[1 month to less than 1 year] 
	How long did you stay in that country? "
data[, 41] <- factor(data[, 41], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[41] <- "Question 11_SQ002"

data[, 42] <- as.numeric(data[, 42])
attributes(data)$variable.labels[42] <- "[1 year to less than 2 years] 
	How long did you stay in that country? "
data[, 42] <- factor(data[, 42], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[42] <- "Question 11_SQ003"

data[, 43] <- as.numeric(data[, 43])
attributes(data)$variable.labels[43] <- "[2 years to less than 3 years] 
	How long did you stay in that country? "
data[, 43] <- factor(data[, 43], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[43] <- "Question 11_SQ004"

data[, 44] <- as.numeric(data[, 44])
attributes(data)$variable.labels[44] <- "[3 years to less than 5 years] 
	How long did you stay in that country? "
data[, 44] <- factor(data[, 44], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[44] <- "Question 11_SQ005"

data[, 45] <- as.numeric(data[, 45])
attributes(data)$variable.labels[45] <- "[5 years and more] 
	How long did you stay in that country? "
data[, 45] <- factor(data[, 45], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[45] <- "Question 11_SQ006"

data[, 46] <- as.character(data[, 46])
attributes(data)$variable.labels[46] <- "Why did you decide to come to Turkey?"
names(data)[46] <- "Question 12"

data[, 47] <- as.character(data[, 47])
attributes(data)$variable.labels[47] <- "How do you access information on your travel route, asylum procedures, means of travel, border crossings, registration, access to services, procedures, etc?"
names(data)[47] <- "Question 13"

data[, 48] <- as.numeric(data[, 48])
attributes(data)$variable.labels[48] <- "In your country of origin, did you use to work?"
data[, 48] <- factor(data[, 48], levels=c(1,2),labels=c("Yes","No"))
names(data)[48] <- "Question 14"

data[, 49] <- as.numeric(data[, 49])
attributes(data)$variable.labels[49] <- "[Accountant ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 49] <- factor(data[, 49], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[49] <- "Question 15_1"

data[, 50] <- as.numeric(data[, 50])
attributes(data)$variable.labels[50] <- "[Aircraft pilot/related professionals ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 50] <- factor(data[, 50], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[50] <- "Question 15_2"

data[, 51] <- as.numeric(data[, 51])
attributes(data)$variable.labels[51] <- "[Architect ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 51] <- factor(data[, 51], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[51] <- "Question 15_3"

data[, 52] <- as.numeric(data[, 52])
attributes(data)$variable.labels[52] <- "[Artist/sculptor/related ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 52] <- factor(data[, 52], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[52] <- "Question 15_4"

data[, 53] <- as.numeric(data[, 53])
attributes(data)$variable.labels[53] <- "[Author/journalist/writer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 53] <- factor(data[, 53], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[53] <- "Question 15_5"

data[, 54] <- as.numeric(data[, 54])
attributes(data)$variable.labels[54] <- "[Baker/pastry-cook related ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 54] <- factor(data[, 54], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[54] <- "Question 15_6"

data[, 55] <- as.numeric(data[, 55])
attributes(data)$variable.labels[55] <- "[Blacksmith ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 55] <- factor(data[, 55], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[55] <- "Question 15_7"

data[, 56] <- as.numeric(data[, 56])
attributes(data)$variable.labels[56] <- "[Bricklayer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 56] <- factor(data[, 56], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[56] <- "Question 15_8"

data[, 57] <- as.numeric(data[, 57])
attributes(data)$variable.labels[57] <- "[Builder ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 57] <- factor(data[, 57], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[57] <- "Question 15_9"

data[, 58] <- as.numeric(data[, 58])
attributes(data)$variable.labels[58] <- "[Building caretaker ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 58] <- factor(data[, 58], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[58] <- "Question 15_10"

data[, 59] <- as.numeric(data[, 59])
attributes(data)$variable.labels[59] <- "[Driver ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 59] <- factor(data[, 59], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[59] <- "Question 15_11"

data[, 60] <- as.numeric(data[, 60])
attributes(data)$variable.labels[60] <- "[Business services agent ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 60] <- factor(data[, 60], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[60] <- "Question 15_12"

data[, 61] <- as.numeric(data[, 61])
attributes(data)$variable.labels[61] <- "[Butcher ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 61] <- factor(data[, 61], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[61] <- "Question 15_13"

data[, 62] <- as.numeric(data[, 62])
attributes(data)$variable.labels[62] <- "[Carpenter ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 62] <- factor(data[, 62], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[62] <- "Question 15_14"

data[, 63] <- as.numeric(data[, 63])
attributes(data)$variable.labels[63] <- "[Clerk ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 63] <- factor(data[, 63], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[63] <- "Question 15_15"

data[, 64] <- as.numeric(data[, 64])
attributes(data)$variable.labels[64] <- "[Computer equipment operator ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 64] <- factor(data[, 64], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[64] <- "Question 15_16"

data[, 65] <- as.numeric(data[, 65])
attributes(data)$variable.labels[65] <- "[Computer programmer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 65] <- factor(data[, 65], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[65] <- "Question 15_17"

data[, 66] <- as.numeric(data[, 66])
attributes(data)$variable.labels[66] <- "[Cook ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 66] <- factor(data[, 66], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[66] <- "Question 15_18"

data[, 67] <- as.numeric(data[, 67])
attributes(data)$variable.labels[67] <- "[Craftsman ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 67] <- factor(data[, 67], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[67] <- "Question 15_19"

data[, 68] <- as.numeric(data[, 68])
attributes(data)$variable.labels[68] <- "[Dairy producer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 68] <- factor(data[, 68], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[68] <- "Question 15_20"

data[, 69] <- as.numeric(data[, 69])
attributes(data)$variable.labels[69] <- "[Dentist ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 69] <- factor(data[, 69], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[69] <- "Question 15_21"

data[, 70] <- as.numeric(data[, 70])
attributes(data)$variable.labels[70] <- "[Domestic helper/cleaner/Housekeeper ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 70] <- factor(data[, 70], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[70] <- "Question 15_22"

data[, 71] <- as.numeric(data[, 71])
attributes(data)$variable.labels[71] <- "[Doorkeeper/watchperson ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 71] <- factor(data[, 71], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[71] <- "Question 15_23"

data[, 72] <- as.numeric(data[, 72])
attributes(data)$variable.labels[72] <- "[Electrical engineer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 72] <- factor(data[, 72], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[72] <- "Question 15_24"

data[, 73] <- as.numeric(data[, 73])
attributes(data)$variable.labels[73] <- "[Electronic/Telecommunications engineer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 73] <- factor(data[, 73], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[73] <- "Question 15_25"

data[, 74] <- as.numeric(data[, 74])
attributes(data)$variable.labels[74] <- "[Electronics mechanic/servicer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 74] <- factor(data[, 74], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[74] <- "Question 15_26"

data[, 75] <- as.numeric(data[, 75])
attributes(data)$variable.labels[75] <- "[Engineer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 75] <- factor(data[, 75], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[75] <- "Question 15_27"

data[, 76] <- as.numeric(data[, 76])
attributes(data)$variable.labels[76] <- "[Farmer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 76] <- factor(data[, 76], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[76] <- "Question 15_28"

data[, 77] <- as.numeric(data[, 77])
attributes(data)$variable.labels[77] <- "[Farm-hand & laborer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 77] <- factor(data[, 77], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[77] <- "Question 15_29"

data[, 78] <- as.numeric(data[, 78])
attributes(data)$variable.labels[78] <- "[Garbage collector ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 78] <- factor(data[, 78], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[78] <- "Question 15_30"

data[, 79] <- as.numeric(data[, 79])
attributes(data)$variable.labels[79] <- "[Gardener/horticultural grower ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 79] <- factor(data[, 79], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[79] <- "Question 15_31"

data[, 80] <- as.numeric(data[, 80])
attributes(data)$variable.labels[80] <- "[General manager(own or small business) ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 80] <- factor(data[, 80], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[80] <- "Question 15_32"

data[, 81] <- as.numeric(data[, 81])
attributes(data)$variable.labels[81] <- "[Glassmaker ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 81] <- factor(data[, 81], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[81] <- "Question 15_33"

data[, 82] <- as.numeric(data[, 82])
attributes(data)$variable.labels[82] <- "[Hairdresser/barber/beautician and related ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 82] <- factor(data[, 82], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[82] <- "Question 15_34"

data[, 83] <- as.numeric(data[, 83])
attributes(data)$variable.labels[83] <- "[Handicraft worker in textile/leather & related ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 83] <- factor(data[, 83], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[83] <- "Question 15_35"

data[, 84] <- as.numeric(data[, 84])
attributes(data)$variable.labels[84] <- "[Handicraft worker inwood & related materials ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 84] <- factor(data[, 84], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[84] <- "Question 15_36"

data[, 85] <- as.numeric(data[, 85])
attributes(data)$variable.labels[85] <- "[Helper/cleaner in offices, hotels etc. ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 85] <- factor(data[, 85], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[85] <- "Question 15_37"

data[, 86] <- as.numeric(data[, 86])
attributes(data)$variable.labels[86] <- "[Hunter ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 86] <- factor(data[, 86], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[86] <- "Question 15_38"

data[, 87] <- as.numeric(data[, 87])
attributes(data)$variable.labels[87] <- "[Jewel maker ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 87] <- factor(data[, 87], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[87] <- "Question 15_39"

data[, 88] <- as.numeric(data[, 88])
attributes(data)$variable.labels[88] <- "[Judge ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 88] <- factor(data[, 88], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[88] <- "Question 15_40"

data[, 89] <- as.numeric(data[, 89])
attributes(data)$variable.labels[89] <- "[Machine operator ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 89] <- factor(data[, 89], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[89] <- "Question 15_41"

data[, 90] <- as.numeric(data[, 90])
attributes(data)$variable.labels[90] <- "[Market-orientedanimal producer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 90] <- factor(data[, 90], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[90] <- "Question 15_42"

data[, 91] <- as.numeric(data[, 91])
attributes(data)$variable.labels[91] <- "[Mechanical engineer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 91] <- factor(data[, 91], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[91] <- "Question 15_43"

data[, 92] <- as.numeric(data[, 92])
attributes(data)$variable.labels[92] <- "[Medical assistant ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 92] <- factor(data[, 92], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[92] <- "Question 15_44"

data[, 93] <- as.numeric(data[, 93])
attributes(data)$variable.labels[93] <- "[Medical doctor ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 93] <- factor(data[, 93], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[93] <- "Question 15_45"

data[, 94] <- as.numeric(data[, 94])
attributes(data)$variable.labels[94] <- "[Motor vehicle mechanic ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 94] <- factor(data[, 94], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[94] <- "Question 15_46"

data[, 95] <- as.numeric(data[, 95])
attributes(data)$variable.labels[95] <- "[Nurse/midwifery professional ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 95] <- factor(data[, 95], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[95] <- "Question 15_47"

data[, 96] <- as.numeric(data[, 96])
attributes(data)$variable.labels[96] <- "[Photographer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 96] <- factor(data[, 96], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[96] <- "Question 15_48"

data[, 97] <- as.numeric(data[, 97])
attributes(data)$variable.labels[97] <- "[Police officer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 97] <- factor(data[, 97], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[97] <- "Question 15_49"

data[, 98] <- as.numeric(data[, 98])
attributes(data)$variable.labels[98] <- "[Production/operationsdepartment manager ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 98] <- factor(data[, 98], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[98] <- "Question 15_50"

data[, 99] <- as.numeric(data[, 99])
attributes(data)$variable.labels[99] <- "[Radio/TV/related announcer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 99] <- factor(data[, 99], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[99] <- "Question 15_51"

data[, 100] <- as.numeric(data[, 100])
attributes(data)$variable.labels[100] <- "[Religious professional ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 100] <- factor(data[, 100], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[100] <- "Question 15_52"

data[, 101] <- as.numeric(data[, 101])
attributes(data)$variable.labels[101] <- "[Safety/quality inspectors ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 101] <- factor(data[, 101], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[101] <- "Question 15_53"

data[, 102] <- as.numeric(data[, 102])
attributes(data)$variable.labels[102] <- "[Sales representative/merchant/trader ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 102] <- factor(data[, 102], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[102] <- "Question 15_54"

data[, 103] <- as.numeric(data[, 103])
attributes(data)$variable.labels[103] <- "[Salesperson ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 103] <- factor(data[, 103], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[103] <- "Question 15_55"

data[, 104] <- as.numeric(data[, 104])
attributes(data)$variable.labels[104] <- "[Secretary ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 104] <- factor(data[, 104], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[104] <- "Question 15_56"

data[, 105] <- as.numeric(data[, 105])
attributes(data)$variable.labels[105] <- "[Senior official of political-party ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 105] <- factor(data[, 105], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[105] <- "Question 15_57"

data[, 106] <- as.numeric(data[, 106])
attributes(data)$variable.labels[106] <- "[Sewing-machine operator ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 106] <- factor(data[, 106], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[106] <- "Question 15_58"

data[, 107] <- as.numeric(data[, 107])
attributes(data)$variable.labels[107] <- "[Ships’ deck crew ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 107] <- factor(data[, 107], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[107] <- "Question 15_59"

data[, 108] <- as.numeric(data[, 108])
attributes(data)$variable.labels[108] <- "[Shoe cleaning/other street service ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 108] <- factor(data[, 108], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[108] <- "Question 15_60"

data[, 109] <- as.numeric(data[, 109])
attributes(data)$variable.labels[109] <- "[Shoe-maker/related worker ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 109] <- factor(data[, 109], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[109] <- "Question 15_61"

data[, 110] <- as.numeric(data[, 110])
attributes(data)$variable.labels[110] <- "[Statistician ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 110] <- factor(data[, 110], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[110] <- "Question 15_62"

data[, 111] <- as.numeric(data[, 111])
attributes(data)$variable.labels[111] <- "[Sweeper/related laborer ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 111] <- factor(data[, 111], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[111] <- "Question 15_63"

data[, 112] <- as.numeric(data[, 112])
attributes(data)$variable.labels[112] <- "[Tailor/dressmaker/hatter ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 112] <- factor(data[, 112], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[112] <- "Question 15_64"

data[, 113] <- as.numeric(data[, 113])
attributes(data)$variable.labels[113] <- "[Teacher ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 113] <- factor(data[, 113], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[113] <- "Question 15_65"

data[, 114] <- as.numeric(data[, 114])
attributes(data)$variable.labels[114] <- "[Translator/interpreter ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 114] <- factor(data[, 114], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[114] <- "Question 15_66"

data[, 115] <- as.numeric(data[, 115])
attributes(data)$variable.labels[115] <- "[University teaching staff ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 115] <- factor(data[, 115], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[115] <- "Question 15_67"

data[, 116] <- as.numeric(data[, 116])
attributes(data)$variable.labels[116] <- "[Vehicle/window/related cleaners ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 116] <- factor(data[, 116], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[116] <- "Question 15_68"

data[, 117] <- as.numeric(data[, 117])
attributes(data)$variable.labels[117] <- "[Veterinarian ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 117] <- factor(data[, 117], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[117] <- "Question 15_69"

data[, 118] <- as.numeric(data[, 118])
attributes(data)$variable.labels[118] <- "[Waiter/waitresses/bartender ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 118] <- factor(data[, 118], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[118] <- "Question 15_70"

data[, 119] <- as.numeric(data[, 119])
attributes(data)$variable.labels[119] <- "[Weaver/knitter ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 119] <- factor(data[, 119], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[119] <- "Question 15_71"

data[, 120] <- as.numeric(data[, 120])
attributes(data)$variable.labels[120] <- "[Welder ] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
data[, 120] <- factor(data[, 120], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[120] <- "Question 15_72"

data[, 121] <- as.character(data[, 121])
attributes(data)$variable.labels[121] <- "[Other] 
	Please tick the job that applies to the foreigners in his/ her country of origin"
names(data)[121] <- "Question 15_other"

data[, 122] <- as.character(data[, 122])
attributes(data)$variable.labels[122] <- "How long have you been in Turkey? 

	 "
data[, 122] <- factor(data[, 122], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("30 Days","1 month to less than 1 year","1 year to less than 2 years","2 years to less than 3 years","3 years to less than 5 years","5 years and more"))
names(data)[122] <- "Question 16"

data[, 123] <- as.numeric(data[, 123])
attributes(data)$variable.labels[123] <- "Are you registered with the authorities in Turkey?"
data[, 123] <- factor(data[, 123], levels=c(1,2),labels=c("Yes","No"))
names(data)[123] <- "Question 17"

data[, 124] <- as.numeric(data[, 124])
attributes(data)$variable.labels[124] <- "[Yes] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
data[, 124] <- factor(data[, 124], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[124] <- "Question 18_SQ001"

data[, 125] <- as.numeric(data[, 125])
attributes(data)$variable.labels[125] <- "[No] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
data[, 125] <- factor(data[, 125], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[125] <- "Question 18_SQ002"

data[, 126] <- as.numeric(data[, 126])
attributes(data)$variable.labels[126] <- "[No, Because I don’t know how to take it] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
data[, 126] <- factor(data[, 126], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[126] <- "Question 18_SQ003"

data[, 127] <- as.numeric(data[, 127])
attributes(data)$variable.labels[127] <- "[No, Because, I applied to the authorities, but I haven’t received it yet] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
data[, 127] <- factor(data[, 127], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[127] <- "Question 18_SQ004"

data[, 128] <- as.numeric(data[, 128])
attributes(data)$variable.labels[128] <- "[No, Because I did not apply to Turkish authorities	] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
data[, 128] <- factor(data[, 128], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[128] <- "Question 18_SQ005"

data[, 129] <- as.character(data[, 129])
attributes(data)$variable.labels[129] <- "[Other] Do you have foreigner’s ID Number (an 11 digit number begins with 99 or 98)"
names(data)[129] <- "Question 18_other"

data[, 130] <- as.character(data[, 130])
attributes(data)$variable.labels[130] <- ""
data[, 130] <- factor(data[, 130], levels=c("SQ001","SQ002","SQ003"),labels=c("Because I don’t know how to take it","Because, I applied to the authorities, but I haven’t received it yet","Because I did not apply to Turkish authorities"))
names(data)[130] <- "Question 18 _hyph_ A"

data[, 131] <- as.character(data[, 131])
attributes(data)$variable.labels[131] <- "[Other]"
names(data)[131] <- "Question 18 _hyph_ A_other"

data[, 132] <- as.numeric(data[, 132])
attributes(data)$variable.labels[132] <- "Did you register with UNHCR?"
data[, 132] <- factor(data[, 132], levels=c(1,2),labels=c("Yes","No"))
names(data)[132] <- "Question 19"

data[, 133] <- as.numeric(data[, 133])
attributes(data)$variable.labels[133] <- "[I want to resettle to a third country through UNHCR] Why did you register with UNHCR?"
data[, 133] <- factor(data[, 133], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[133] <- "Question 20_SQ001"

data[, 134] <- as.numeric(data[, 134])
attributes(data)$variable.labels[134] <- "[I heard about UNHCR from my relatives/neighbors/other compatriots from CoO and they told me to approach] Why did you register with UNHCR?"
data[, 134] <- factor(data[, 134], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[134] <- "Question 20_SQ002"

data[, 135] <- as.numeric(data[, 135])
attributes(data)$variable.labels[135] <- "[UNHCR would give me documentation] Why did you register with UNHCR?"
data[, 135] <- factor(data[, 135], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[135] <- "Question 20_SQ003"

data[, 136] <- as.numeric(data[, 136])
attributes(data)$variable.labels[136] <- "[I want to move to Greece and the documentation will help me to travel ] Why did you register with UNHCR?"
data[, 136] <- factor(data[, 136], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[136] <- "Question 20_SQ004"

data[, 137] <- as.numeric(data[, 137])
attributes(data)$variable.labels[137] <- "[I don’t know where else to apply] Why did you register with UNHCR?"
data[, 137] <- factor(data[, 137], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[137] <- "Question 20_SQ005"

data[, 138] <- as.character(data[, 138])
attributes(data)$variable.labels[138] <- "In which city have you been residing in Turkey?"
names(data)[138] <- "Question 21"

data[, 139] <- as.numeric(data[, 139])
attributes(data)$variable.labels[139] <- "Have you stayed in the camp in Turkey? "
data[, 139] <- factor(data[, 139], levels=c(1,2),labels=c("Yes","No"))
names(data)[139] <- "Question 22"

data[, 140] <- as.character(data[, 140])
attributes(data)$variable.labels[140] <- "Why did you leave the camp and arrive in this city?"
names(data)[140] <- "Question 23"

data[, 141] <- as.character(data[, 141])
attributes(data)$variable.labels[141] <- "Do you have any relatives left behind in the camp/or in the city where you used to reside in Turkey?"
names(data)[141] <- "Question 24"

data[, 142] <- as.character(data[, 142])
attributes(data)$variable.labels[142] <- "In Turkey, have you ever worked in Turkey? (PLEASE TICK ONLY ONE BOX)"
data[, 142] <- factor(data[, 142], levels=c("A1","A2","A3"),labels=c("Yes, I had a stable job","I work casually; when I find a work","No I have never worked in Turkey"))
names(data)[142] <- "Question 25"

data[, 143] <- as.character(data[, 143])
attributes(data)$variable.labels[143] <- "How did you find job in Turkey?"
data[, 143] <- factor(data[, 143], levels=c("A1","A2","A3","A4","A5"),labels=c("With the help of local community","With the help of other refugees/asylum seekers","With the help of NGO/Foundation/Association","I found it myself","I was employed by a Syrian"))
names(data)[143] <- "Question 26"

data[, 144] <- as.numeric(data[, 144])
attributes(data)$variable.labels[144] <- "Did you have work permit?"
data[, 144] <- factor(data[, 144], levels=c(1,2),labels=c("Yes","No"))
names(data)[144] <- "Question 27"

data[, 145] <- as.character(data[, 145])
attributes(data)$variable.labels[145] <- "Which one among the below describes your situation?"
data[, 145] <- factor(data[, 145], levels=c("A1","A2","A3","A4"),labels=c("I earn more than Turkish Citizens","I earn same as Turkish citizens","I earn less than Turkish citizens","I don’t get paid regularly"))
names(data)[145] <- "Question 28"

data[, 146] <- as.numeric(data[, 146])
attributes(data)$variable.labels[146] <- "Do you have problems in relation to your working conditions?"
data[, 146] <- factor(data[, 146], levels=c(1,2),labels=c("Yes","No"))
names(data)[146] <- "Question 29"

data[, 147] <- as.numeric(data[, 147])
attributes(data)$variable.labels[147] <- "[The working hours are too long when compared to my salary] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 147] <- factor(data[, 147], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[147] <- "Question 29 A_SQ001"

data[, 148] <- as.numeric(data[, 148])
attributes(data)$variable.labels[148] <- "[I face annoying behavior by my employer/supervisor*] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 148] <- factor(data[, 148], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[148] <- "Question 29 A_SQ002"

data[, 149] <- as.numeric(data[, 149])
attributes(data)$variable.labels[149] <- "[I face annoying behavior* by other employee(s)  (Please explain in the box below)] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 149] <- factor(data[, 149], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[149] <- "Question 29 A_SQ003"

data[, 150] <- as.numeric(data[, 150])
attributes(data)$variable.labels[150] <- "[I cannot get my salary in time] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 150] <- factor(data[, 150], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[150] <- "Question 29 A_SQ004"

data[, 151] <- as.numeric(data[, 151])
attributes(data)$variable.labels[151] <- "[I cannot get my salary  in the amount we agreed on] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 151] <- factor(data[, 151], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[151] <- "Question 29 A_SQ005"

data[, 152] <- as.numeric(data[, 152])
attributes(data)$variable.labels[152] <- "[My salary does not reflect the hardship of my job] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 152] <- factor(data[, 152], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[152] <- "Question 29 A_SQ006"

data[, 153] <- as.numeric(data[, 153])
attributes(data)$variable.labels[153] <- "[I work longer than we agreed on, but cannot get extra money for the extra time] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 153] <- factor(data[, 153], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[153] <- "Question 29 A_SQ007"

data[, 154] <- as.numeric(data[, 154])
attributes(data)$variable.labels[154] <- "[My employer/supervisor wants me to fulfill duties that are not included in my work definition] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 154] <- factor(data[, 154], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[154] <- "Question 29 A_SQ008"

data[, 155] <- as.numeric(data[, 155])
attributes(data)$variable.labels[155] <- "[I face rude expressions] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 155] <- factor(data[, 155], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[155] <- "Question 29 A_SQ009"

data[, 156] <- as.numeric(data[, 156])
attributes(data)$variable.labels[156] <- "[My employer holds my legal documents and does not give them back] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 156] <- factor(data[, 156], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[156] <- "Question 29 A_SQ010"

data[, 157] <- as.numeric(data[, 157])
attributes(data)$variable.labels[157] <- "[I face annoying behavior by locals because I am working] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
data[, 157] <- factor(data[, 157], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[157] <- "Question 29 A_SQ011"

data[, 158] <- as.character(data[, 158])
attributes(data)$variable.labels[158] <- "[Other] I have following problems related to my working conditions in Turkey (Please tick as many boxes as applies to your case)"
names(data)[158] <- "Question 29 A_other"

data[, 159] <- as.character(data[, 159])
attributes(data)$variable.labels[159] <- "Please Explain"
names(data)[159] <- "Question 29 B"

data[, 160] <- as.character(data[, 160])
attributes(data)$variable.labels[160] <- "Are your children (between 6 and 18) officially registered to primary/secondary/high state school in Turkey? Please tick the box(es) that suits best to the individual’s children’s case. If Not registered and not attending school pleasing explain why?"
data[, 160] <- factor(data[, 160], levels=c("A1","A2","A3"),labels=c("Yes, they are officially registered to primary/secondary/high school","No, they are not officially registered but go to primary/secondary/high school","No, they are not officially registered and do not go to primary/secondary/high school*"))
names(data)[160] <- "Question 30"

data[, 161] <- as.character(data[, 161])
attributes(data)$variable.labels[161] <- "[Comment] Are your children (between 6 and 18) officially registered to primary/secondary/high state school in Turkey? Please tick the box(es) that suits best to the individual’s children’s case. If Not registered and not attending school pleasing explain why?"
names(data)[161] <- "Question 30_comment"

data[, 162] <- as.character(data[, 162])
attributes(data)$variable.labels[162] <- "If your children are not registered in Turkish State schools, do they go to any different type of school? Please explain: "
names(data)[162] <- "Question 31"

data[, 163] <- as.character(data[, 163])
attributes(data)$variable.labels[163] <- "Çocuklarınız Devlet okullarına kayıtlı değilse, farklı türdeki okullara gidiyor muydu?"
names(data)[163] <- "Question 31 A"

data[, 164] <- as.numeric(data[, 164])
attributes(data)$variable.labels[164] <- "If the individual is over 18 – Did you try to continue your higher education in Turkey?"
data[, 164] <- factor(data[, 164], levels=c(1,2),labels=c("Yes","No"))
names(data)[164] <- "Question 32"

data[, 165] <- as.character(data[, 165])
attributes(data)$variable.labels[165] <- "What was the reason that you discontinued your education in Turkey?"
names(data)[165] <- "Question 33"

data[, 166] <- as.character(data[, 166])
attributes(data)$variable.labels[166] <- "Why have you not take steps to continue your higher education in Turkey?"
data[, 166] <- factor(data[, 166], levels=c("A1","A2","A3","A4"),labels=c("Language barrier","I did not know that it was possible","I do not want to stay in Turkey","I want to continue my education in Europe because of better opportunities"))
names(data)[166] <- "Question 34"

data[, 167] <- as.numeric(data[, 167])
attributes(data)$variable.labels[167] <- "Do you have chronic health problems?"
data[, 167] <- factor(data[, 167], levels=c(1,2),labels=c("Yes","No"))
names(data)[167] <- "Question 35"

data[, 168] <- as.character(data[, 168])
attributes(data)$variable.labels[168] <- "Did you have access to health services in Turkey?"
data[, 168] <- factor(data[, 168], levels=c("A1","A2","A3","A4","A5"),labels=c("Yes, without any problems","Yes, but could not get medicine","No, I cannot receive treatment because I don’t have money","No, I cannot receive any treatment due to lack of infrastructure","No, because I don’t have an ID document"))
names(data)[168] <- "Question 36"

data[, 169] <- as.character(data[, 169])
attributes(data)$variable.labels[169] <- "[It is too costly to live in Turkey] What are your reasons to leave Turkey?"
data[, 169] <- factor(data[, 169], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[169] <- "Question 37_SQ001"

data[, 170] <- as.character(data[, 170])
attributes(data)$variable.labels[170] <- "[People in Turkey are hostile] What are your reasons to leave Turkey?"
data[, 170] <- factor(data[, 170], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[170] <- "Question 37_SQ002"

data[, 171] <- as.character(data[, 171])
attributes(data)$variable.labels[171] <- "[I want to unite with my relatives residing abroad] What are your reasons to leave Turkey?"
data[, 171] <- factor(data[, 171], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[171] <- "Question 37_SQ003"

data[, 172] <- as.character(data[, 172])
attributes(data)$variable.labels[172] <- "[I do not have any work opportunities in Turkey] What are your reasons to leave Turkey?"
data[, 172] <- factor(data[, 172], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[172] <- "Question 37_SQ004"

data[, 173] <- as.character(data[, 173])
attributes(data)$variable.labels[173] <- "[Exploitation at the workplace] What are your reasons to leave Turkey?"
data[, 173] <- factor(data[, 173], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[173] <- "Question 37_SQ005"

data[, 174] <- as.character(data[, 174])
attributes(data)$variable.labels[174] <- "[I have poor quality of life in Turkey ] What are your reasons to leave Turkey?"
data[, 174] <- factor(data[, 174], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[174] <- "Question 37_SQ006"

data[, 175] <- as.character(data[, 175])
attributes(data)$variable.labels[175] <- "[I feel isolated in Turkey] What are your reasons to leave Turkey?"
data[, 175] <- factor(data[, 175], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[175] <- "Question 37_SQ007"

data[, 176] <- as.character(data[, 176])
attributes(data)$variable.labels[176] <- "[I cannot benefit from medical services in Turkey] What are your reasons to leave Turkey?"
data[, 176] <- factor(data[, 176], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[176] <- "Question 37_SQ008"

data[, 177] <- as.character(data[, 177])
attributes(data)$variable.labels[177] <- "[ I/My children cannot continue education in Turkey] What are your reasons to leave Turkey?"
data[, 177] <- factor(data[, 177], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[177] <- "Question 37_SQ009"

data[, 178] <- as.character(data[, 178])
attributes(data)$variable.labels[178] <- "[I have security problems in Turkey] What are your reasons to leave Turkey?"
data[, 178] <- factor(data[, 178], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[178] <- "Question 37_SQ010"

data[, 179] <- as.character(data[, 179])
attributes(data)$variable.labels[179] <- "[I find Turkish culture hard to adopt] What are your reasons to leave Turkey?"
data[, 179] <- factor(data[, 179], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[179] <- "Question 37_SQ011"

data[, 180] <- as.character(data[, 180])
attributes(data)$variable.labels[180] <- "[I do not find myself comfortable in terms of my religious convictions in Turkey] What are your reasons to leave Turkey?"
data[, 180] <- factor(data[, 180], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[180] <- "Question 37_SQ012"

data[, 181] <- as.character(data[, 181])
attributes(data)$variable.labels[181] <- "[The language is difficult for me] What are your reasons to leave Turkey?"
data[, 181] <- factor(data[, 181], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[181] <- "Question 37_SQ013"

data[, 182] <- as.character(data[, 182])
attributes(data)$variable.labels[182] <- "[ I want (or my children) to continue education abroad] What are your reasons to leave Turkey?"
data[, 182] <- factor(data[, 182], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[182] <- "Question 37_SQ014"

data[, 183] <- as.character(data[, 183])
attributes(data)$variable.labels[183] <- "[I am not going to be resettled by UNHCR] What are your reasons to leave Turkey?"
data[, 183] <- factor(data[, 183], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[183] <- "Question 37_SQ015"

data[, 184] <- as.character(data[, 184])
attributes(data)$variable.labels[184] <- "[I want to have better future for myself and my children ] What are your reasons to leave Turkey?"
data[, 184] <- factor(data[, 184], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[184] <- "Question 37_SQ016"

data[, 185] <- as.character(data[, 185])
attributes(data)$variable.labels[185] <- "[It is too close to Syria ] What are your reasons to leave Turkey?"
data[, 185] <- factor(data[, 185], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[185] <- "Question 37_SQ017"

data[, 186] <- as.character(data[, 186])
attributes(data)$variable.labels[186] <- "[Other] What are your reasons to leave Turkey?"
data[, 186] <- factor(data[, 186], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("0","1","2","3","4","5"))
names(data)[186] <- "Question 37_SQ018"

data[, 187] <- as.numeric(data[, 187])
attributes(data)$variable.labels[187] <- "Have you tried to cross to Greece before?"
data[, 187] <- factor(data[, 187], levels=c(1,2),labels=c("Yes","No"))
names(data)[187] <- "Question 38"

data[, 188] <- as.character(data[, 188])
attributes(data)$variable.labels[188] <- "How many times did you attempt to cross Greece?"
data[, 188] <- factor(data[, 188], levels=c("A1","A2","A3"),labels=c("1","2","More than 3"))
names(data)[188] <- "Question 39"

data[, 189] <- as.numeric(data[, 189])
attributes(data)$variable.labels[189] <- "Do you plan to try again?"
data[, 189] <- factor(data[, 189], levels=c(1,2),labels=c("Yes","No"))
names(data)[189] <- "Question 40"

data[, 190] <- as.numeric(data[, 190])
attributes(data)$variable.labels[190] <- "Have you ever been stopped and returned to Turkey by the Greek Coast Guards"
data[, 190] <- factor(data[, 190], levels=c(1,2),labels=c("Yes","No"))
names(data)[190] <- "Question 41"

data[, 191] <- as.character(data[, 191])
attributes(data)$variable.labels[191] <- "What are your future plans/ intentions?"
names(data)[191] <- "Question 42"

data[, 192] <- as.character(data[, 192])
attributes(data)$variable.labels[192] <- "Which country is your final destination?"
names(data)[192] <- "Question 43"

data[, 193] <- as.character(data[, 193])
attributes(data)$variable.labels[193] <- "[I have relatives in this country] Why do you want to go to this country?"
data[, 193] <- factor(data[, 193], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[193] <- "Question 44_SQ001"

data[, 194] <- as.character(data[, 194])
attributes(data)$variable.labels[194] <- "[I know that they will financially help me there    ] Why do you want to go to this country?"
data[, 194] <- factor(data[, 194], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[194] <- "Question 44_SQ002"

data[, 195] <- as.character(data[, 195])
attributes(data)$variable.labels[195] <- "[I can work there] Why do you want to go to this country?"
data[, 195] <- factor(data[, 195], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[195] <- "Question 44_SQ003"

data[, 196] <- as.character(data[, 196])
attributes(data)$variable.labels[196] <- "[I want to continue my education there] Why do you want to go to this country?"
data[, 196] <- factor(data[, 196], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[196] <- "Question 44_SQ004"

data[, 197] <- as.character(data[, 197])
attributes(data)$variable.labels[197] <- "[I can be a citizen there] Why do you want to go to this country?"
data[, 197] <- factor(data[, 197], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[197] <- "Question 44_SQ005"

data[, 198] <- as.character(data[, 198])
attributes(data)$variable.labels[198] <- "[I can apply for asylum there] Why do you want to go to this country?"
data[, 198] <- factor(data[, 198], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[198] <- "Question 44_SQ006"

data[, 199] <- as.character(data[, 199])
attributes(data)$variable.labels[199] <- "[My children would have better future] Why do you want to go to this country?"
data[, 199] <- factor(data[, 199], levels=c("A1","A2","A3","A4","A5","A6"),labels=c("N/A","1","2","3","4","5"))
names(data)[199] <- "Question 44_SQ007"

data[, 200] <- as.character(data[, 200])
attributes(data)$variable.labels[200] <- "Would you prefer to stay in Turkey rather than going to another country, if you had the chance?"
data[, 200] <- factor(data[, 200], levels=c("A1","A2"),labels=c("Yes, I would prefer to stay in Turkey if I had the chance","No, I want to leave Turkey as soon as possible"))
names(data)[200] <- "Question 45"






data[, 201] <- as.numeric(data[, 201])
attributes(data)$variable.labels[201] <- "[Employment] What would make you stay in Turkey?"
names(data)[201] <- "Question 46_SQ001"

data[, 202] <- as.numeric(data[, 202])
attributes(data)$variable.labels[202] <- "[Education opportunities] What would make you stay in Turkey?"
names(data)[202] <- "Question 46_SQ002"

data[, 203] <- as.numeric(data[, 203])
attributes(data)$variable.labels[203] <- "[Material support] What would make you stay in Turkey?"
names(data)[203] <- "Question 46_SQ003"

data[, 204] <- as.numeric(data[, 204])
attributes(data)$variable.labels[204] <- "[Shelter support] What would make you stay in Turkey?"
names(data)[204] <- "Question 46_SQ004"

data[, 205] <- as.numeric(data[, 205])
attributes(data)$variable.labels[205] <- "[Unaccompanied and separated child  ] Any specific needs identified."
data[, 205] <- factor(data[, 205], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[205] <- "Question 47_SQ001"

data[, 206] <- as.numeric(data[, 206])
attributes(data)$variable.labels[206] <- "[Female Head of Household] Any specific needs identified."
data[, 206] <- factor(data[, 206], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[206] <- "Question 47_SQ002"

data[, 207] <- as.numeric(data[, 207])
attributes(data)$variable.labels[207] <- "[Medical problems] Any specific needs identified."
data[, 207] <- factor(data[, 207], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[207] <- "Question 47_SQ003"

data[, 208] <- as.numeric(data[, 208])
attributes(data)$variable.labels[208] <- "[Disabled ] Any specific needs identified."
data[, 208] <- factor(data[, 208], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[208] <- "Question 47_SQ004"

data[, 209] <- as.numeric(data[, 209])
attributes(data)$variable.labels[209] <- "[Victim of torture ] Any specific needs identified."
data[, 209] <- factor(data[, 209], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[209] <- "Question 47_SQ005"

data[, 210] <- as.numeric(data[, 210])
attributes(data)$variable.labels[210] <- "[Pregnant woman ] Any specific needs identified."
data[, 210] <- factor(data[, 210], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[210] <- "Question 47_SQ006"

data[, 211] <- as.numeric(data[, 211])
attributes(data)$variable.labels[211] <- "[Elderly ] Any specific needs identified."
data[, 211] <- factor(data[, 211], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[211] <- "Question 47_SQ007"

data[, 212] <- as.numeric(data[, 212])
attributes(data)$variable.labels[212] <- "[LGBTi] Any specific needs identified."
data[, 212] <- factor(data[, 212], levels=c(1,0),labels=c("Yes","Not selected"))
names(data)[212] <- "Question 47_SQ008"

data[, 213] <- as.character(data[, 213])
attributes(data)$variable.labels[213] <- "Date of the interview"
names(data)[213] <- "Int 1"

data[, 214] <- as.character(data[, 214])
attributes(data)$variable.labels[214] <- "Name of the Interviewer"
names(data)[214] <- "Int 2"

data[, 215] <- as.character(data[, 215])
attributes(data)$variable.labels[215] <- "Location of the Interview"
names(data)[215] <- "Int 3"

# Variable name was incorrect and was changed from Question 18 - A to Question 18 _hyph_ A .
# Variable name was incorrect and was changed from Question 18 - A_other to Question 18 _hyph_ A_other .

### Save to Rdatset


## Delete empty records -- using rows with empty title
data1 <- data[!is.na(data$submitdate), ]
## use label as variable name
for (i in 1:215 ) {
  names(data1)[i] <- attributes(data1)$variable.labels[i]
}
write.csv(data1, file="data/data.csv")

saveRDS(data, "data/data.rds")
save(data1, file = "data/data.rda")
load(file = "data/data.rda")

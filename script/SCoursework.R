oscars<-read.csv("oscars.csv", header=TRUE)
# 1. Fit the full (largest) model. Interpret one of the significant coefficients and report the confidence interval
head(oscars)
attach(oscars)

#Remove current year unknown
MP_Nomination <- oscars[oscars$Ch != 0, ]

#convert 1 to 1 and 2 to 0 in Ch
MP_Win <- ifelse(oscars$Ch == 1, 1, 0)

#Fix Scr data as it shows that it has 2 nominations when it can have only one
oscars$Nom[Scr == 2]<- Nom[Scr == 2] - 1
oscars$Scr[Scr == 2]<-1

#List the predictors
selected_categories<-c("Year","Nom","Dir","Aml","Afl","Ams","Afs","Scr","Cin","Art","Cos","Sco","Son","Edi","Sou","For","Anf","Eff","Mak","Dan","AD","Gdr","Gmc","Gd","Gm1","Gm2","Gf1","Gf2","PGA","DGA","Action","Adventure","Animation","Biography","Comedy","Crime","Docu","Drama","Family","Fantasy","Film.noir","History","Horror","Music","Musical","Mystery","Romance","SciFi","Sport","Thriller","War","Western","Length","Days","G","PG","PG13","R","U","Ebert","NYFCC","LAFCA","NSFC","NBR","WR")
selected_categories<-intersect(names(oscars), selected_categories)
categories<-oscars[,selected_categories]
categories$MP_Win<-MP_Win

#Set the response variable as a binary with levels 1 ("Winner") and 0 ("Not Winner")
categories$MP_Win <- as.factor(categories$MP_Win)
levels(categories$MP_Win) <- c(0, 1)

#Fit the model
ModelFull<-glm(MP_Win~.,data=categories, family=binomial)
summary(ModelFull)

#Interpret one of the significant coefficients and it's confidence interval
odds_ratio <- exp(coef(ModelFull))
print(odds_ratio)
#The odds ratio for PGA is 4.242515e+01>1 meaning it PGA is more likely to affect the outcome 
confidence_interval <- exp(confint.default(ModelFull))
print(confidence_interval)
#The confidence interval for PGA is [1.534076e+01, 1.173275e+02]

#2. Use an appropriate model selection strategy and choose the best model
#Most of the predictors appears to not be significant so first attempt backward elimination until we get the lowest AIC possible
drop1(ModelFull, test="LRT") #we get the smallest AIC of 380.63 if we remove Afl, Afs, Cos, Anf, Gmc, Gf1, Adventure but we'll remove Anf as it has the largest p-value
model1<-update(ModelFull, .~.-Anf)
drop1(model1, test="LRT") #we get the smallest AIC of 378.63 if we remove Afl, Afs, Cos, Gmc, Gf1, Adventure but we'll remove Gmc as it has the largest p-value
model2<-update(model1, .~.-Gmc)
drop1(model2, test="LRT") #we get the smallest AIC of 376.63   if we remove Afl, Afs, Cos, Gf1, Adventure but we'll remove Afl as it has the largest p-value
model3<-update(model2, .~.-Afl)
drop1(model3, test="LRT") #we get the smallest AIC of 374.63 if we remove Cos ,Gf1, Adventure but we'll remove Adventure as it has the largest p-value
model4<-update(model3, .~.-Adventure)
drop1(model4, test="LRT") #we get the smallest AIC of 372.63 if we remove Cos ,Gf1 but we'll remove Gf1 as it has the largest p-value
model5<-update(model4, .~.-Gf1)
drop1(model5, test="LRT") #we get the smallest AIC of 370.64 if we remove Afs, Cos, Animation, Comedy, Length but we'll remove Cos as it has the largest p-value
model6<-update(model5, .~.-Cos)
drop1(model6, test="LRT") #we get the smallest AIC of 368.64 if we remove Afs, Comedy but we'll remove Afs as it has the largest p-value
model7<-update(model6, .~.-Afs)
drop1(model7, test="LRT") #we get the smallest AIC of 366.64 if we remove Comedy
model8<-update(model7, .~.-Comedy)
drop1(model8, test="LRT") #we get the smallest AIC of 364.65 if we remove Animation
model9<-update(model8, .~.-Animation)
drop1(model9, test="LRT") #we get the smallest AIC of 362.67 if we remove Biography, Western, Length but we'll remove Western as it has the largest p-value
model10<-update(model9, .~.-Western)
drop1(model10, test="LRT") #we get the smallest AIC of 360.68  if we remove Biography, Length but we'll remove Biography as it has the largest p-value
model11<-update(model10, .~.-Biography)
drop1(model11, test="LRT") #we get the smallest AIC of 358.70 if we remove Gm2, Length but we'll remove Length as it has the largest p-value
model12<-update(model11, .~.-Length)
drop1(model12, test="LRT") #we get the smallest AIC of 356.73 if we remove Son, Gm2  but we'll remove Son as it has the largest p-value
model13<-update(model12, .~.-Son)
drop1(model13, test="LRT") #we get the smallest AIC of 354.76 if we remove Gm2
model14<-update(model13, .~.-Gm2)
drop1(model14, test="LRT") #we get the smallest AIC of 352.79 if we remove Art
model15<-update(model14, .~.-Art)
drop1(model15, test="LRT") #we get the smallest AIC of 350.85 if we remove Docu
model16<-update(model15, .~.-Docu)
drop1(model16, test="LRT") #we get the smallest AIC of 348.95 if we remove Sco, PG13 but we'll remove PG13 as it has the largest p-value
model17<-update(model16, .~.-PG13)
drop1(model17, test="LRT") #we get the smallest AIC of 347.05 if we remove U
model18<-update(model17, .~.-U)
drop1(model18, test="LRT") #we get the smallest AIC of 345.16 if we remove R
model19<-update(model18, .~.-R)
drop1(model19, test="LRT") #we get the smallest AIC of 343.26 if we remove G
model20<-update(model19, .~.-G)
drop1(model20, test="LRT") #we get the smallest AIC of 341.36 if we remove SciFi
model21<-update(model20, .~.-SciFi)
drop1(model21, test="LRT") #we get the smallest AIC of 339.50 if we remove Sco, For but we'll remove For as it has the largest p-value
model22<-update(model21, .~.-For)
drop1(model22, test="LRT") #we get the smallest AIC of 337.63 if we remove Sco
model23<-update(model22, .~.-Sco)
drop1(model23, test="LRT") #we get the smallest AIC of 335.87 if we remove NBR
model24<-update(model23, .~.-NBR)
drop1(model24, test="LRT") #we get the smallest AIC of 334.04 if we remove NYFCC
model25<-update(model24, .~.-NYFCC)
drop1(model25, test="LRT") #we get the smallest AIC of 332.32 if we remove Thriller
model26<-update(model25, .~.-Thriller)
drop1(model26, test="LRT") #we get the smallest AIC of 330.61 if we remove Gf2
model27<-update(model26, .~.-Gf2)
drop1(model27, test="LRT") #we get the smallest AIC of 328.89 if we remove Aml
model28<-update(model27, .~.-Aml)
drop1(model28, test="LRT") #we get the smallest AIC of 327.18 if we remove Film.noir
model29<-update(model28, .~.-Film.noir)
drop1(model29, test="LRT") #we get the smallest AIC of 325.54 if we remove Sport
model30<-update(model29, .~.-Sport)
drop1(model30, test="LRT") #we get the smallest AIC of 323.94 if we remove PG
model31<-update(model30, .~.-PG)
drop1(model31, test="LRT") #we get the smallest AIC of 322.34 if we remove Nom, Horror but we'll remove Horror as it has the largest p-value
model32<-update(model31, .~.-Horror)
drop1(model32, test="LRT") #we get the smallest AIC of 320.75 if we remove Nom
model33<-update(model32, .~.-Nom)
drop1(model33, test="LRT") #we get the smallest AIC of 318.97 if we remove Cin
model34<-update(model33, .~.-Cin)
drop1(model34, test="LRT") #we get the smallest AIC of 317.36 if we remove Mystery
model35<-update(model34, .~.-Mystery)
drop1(model35, test="LRT") #we get the smallest AIC of 316.03 if we remove Days
model36<-update(model35, .~.-Days)
drop1(model36, test="LRT") #we get the smallest AIC of 314.59 if we remove History
model37<-update(model36, .~.-History)
drop1(model37, test="LRT") #we get the smallest AIC of 313.41 if we remove Crime
model38<-update(model37, .~.-Crime)
drop1(model38, test="LRT") #we get the smallest AIC of 312.20 if we remove Music
model39<-update(model38, .~.-Music)
drop1(model39, test="LRT") #we get the smallest AIC of 310.98 if we remove AD
model40<-update(model39, .~.-AD)
drop1(model40, test="LRT") #we get the smallest AIC of 309.95 if we remove Scr
model41<-update(model40, .~.-Scr)
drop1(model41, test="LRT") #we get the smallest AIC of 308.78 if we remove Eff
model42<-update(model41, .~.-Eff)
drop1(model42, test="LRT") #we get the smallest AIC of 307.80 if we remove Romance
model43<-update(model42, .~.-Romance)
drop1(model43, test="LRT") #we get the smallest AIC of 307.17 if we remove Action
model44<-update(model43, .~.-Action)
drop1(model44, test="LRT") #we get the smallest AIC of 306.34 if we remove War
model45<-update(model44, .~.-War)
drop1(model45, test="LRT") #we get the smallest AIC of 305.27 if we remove Drama
model46<-update(model45, .~.-Drama)
drop1(model46, test="LRT") #we get the smallest AIC of 304.77 if we remove Family
model47<-update(model46, .~.-Family)
drop1(model47, test="LRT") #we get the smallest AIC of 303.98 if we remove Fantasy
model48<-update(model47, .~.-Fantasy)
drop1(model48, test="LRT") #we get the smallest AIC of 303.39 if we remove Sou
model49<-update(model48, .~.-Sou)
drop1(model49, test="LRT") #we get the smallest AIC of 303.20 if we remove Gm1
model50<-update(model49, .~.-Gm1)
drop1(model50, test="LRT") #we get the smallest AIC of 302.66 if we remove LAFCA
model51<-update(model50, .~.-LAFCA)
drop1(model51, test="LRT") #we get the smallest AIC if we keep the model as it is 
#Our final model is MP_Win ~ Year + Dir + Ams + Edi + Mak + Dan + Gdr + Gd + PGA + DGA + Musical + Ebert + NSFC + WR with AIC=302.66
finalmodel<-model51

#3.Calculate the area under the curve of your final model. Use the optimal threshold based on the ROC curve and calculate the sensitivity of your final model
library(pROC)
fitted_prob <- predict(finalmodel, type="response")
ROC <- roc(categories$MP_Win, fitted_prob, plot=TRUE)
AUC<-auc(ROC)
print(AUC)
#Area under the curve: 0.9327
#As the AUC>0.9 that means the model has excellent predictive ability

#The optimal threshold is found by
ind<-which.min((ROC$sensitivities-1)^2+(ROC$specificities-1)^2)
ROC$thresholds[ind]
#c=0.1352784
points(ROC$specificities[ind],ROC$sensitivities[ind],pch=4, cex= 3, col="red")

#Now to calculate the sensitivity of the model
fitted_c <- ifelse(fitted_prob>ROC$thresholds[ind], "Yes", "No")
table(categories$MP_Win, fitted_c)
sens = 85/(85+11)
print(sens)
#Sensitivity is 0.8854167

#4. Based on your final model, give the predictive probability of winning for each contender in this year's Best Motion Picture Category
#First need to make a list of the movies released a year before this year's Oscars
categories$Name<-Name
Nominees_2024 <- subset(categories, Year == 2024)
pred_probability<-predict(finalmodel, newdata=Nominees_2024, type="response")
Win_probability <- pred_probability/sum(pred_probability)
print(Win_probability)

#Check if sum of the probability equals 1
sum(Win_probability) # it does

#Rank the results
results <- data.frame(Title = Nominees_2024$Name ,Probability = Win_probability)
ranking <- results[order(-results$Probability),]
print(ranking)
#The winner for the Oscars this year is ... Anora!!!

#5. Logistic regression is not the suitable approach to model this type of data. Can you research another model to predict the Oscar winners? Explain why your choice of model can give an output with the predicted probabilities summing up to 1 within each year
# Logistic regression is not suitable as it assume each film is independent from each other when we could have the case where how well one film is received affects another film's chances. In addition, logistic regression doesn't ensure that the sum of predicted probabilities in a given year equals 1. In our case we had to scale the probability to get the sum equal to 1 for each year by dividing the predicted probability by its sum.
# An alternative model would be Multinomial Logistic Regression. This is because the response variable is taken to be categorical with multiple classes rather than just two as in Binary Logistic Regression so we can class each film as "Winner" or "Not Winner". Furthermore, we would automatically get that the predicted probabilities for all films in a given year will add up to 1. 
# However we would still have the assumption that each film's chances at winning is independent from each other. 


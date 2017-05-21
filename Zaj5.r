library("neuralnet")

#Going to create a neural network to perform the rooting of logarithm of x to the power of 2
#Type ?neuralnet for more information on the neuralnet library

#Generate 98 random numbers uniformly distributed between 0 and 100 (for very good results in such a range)
#And store them as a dataframe
traininginput <- as.data.frame(runif(98, min=0, max=100))
trainingoutput <- log(traininginput^2)

#Column bind the data into one variable
trainingdata <- cbind(traininginput,trainingoutput)
colnames(trainingdata) <- c("Input","Output")

#Train the neural network
#Going to have C(8, 5, 3) hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.
net.log <- neuralnet(Output~Input, trainingdata, hidden=c(8, 5, 3), threshold=0.01)
print(net.log)

#Plot the neural network
plot(net.log)

#Test the neural network on some training data
testdata <- as.data.frame((2:20)*0.5) #Generate some numbers between 1 and 10
net.results <- compute(net.log, testdata) #Run them through the neural network

#Lets see what properties net.log has
ls(net.results)

#Lets see the results
print(net.results$net.result)

#Lets display a better version of the results
cleanoutput <- cbind(testdata,log(testdata^2),
                     as.data.frame(net.results$net.result))
colnames(cleanoutput) <- c("Input","Expected Output","Neural Net Output")
print(cleanoutput)
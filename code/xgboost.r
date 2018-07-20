library(useful)
library(xgboost)
library(coefplot)
library(magrittr)
library(dygraphs)

land_train <- readr::read_csv('data/manhattan_Train.csv')
land_test <- readRDS('data/manhattan_Test.rds')
land_val <- readRDS('data/manhattan_Validate.rds')

table(land_train$HistoricDistrict)

histFormula <- HistoricDistrict ~ FireService + 
    ZoneDist1 + ZoneDist2 + Class + LandUse + 
    OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + 
    GarageArea + FactryArea + NumBldgs + 
    NumFloors + UnitsRes + UnitsTotal + 
    LotFront + LotDepth + BldgFront + 
    BldgDepth + LotType + Landmark + BuiltFAR +
    Built + TotalValue - 1

landX_train <- build.x(histFormula, data=land_train, contrasts=FALSE, sparse=TRUE)
landY_train <- build.y(histFormula, data=land_train) %>% as.factor() %>% as.integer() - 1
head(landY_train, n=20)

landX_val <- build.x(histFormula, data=land_val, contrasts=FALSE, sparse=TRUE)
landY_val <- build.y(histFormula, data=land_val) %>% as.factor() %>% as.integer() - 1

landX_test <- build.x(histFormula, data=land_test, contrasts=FALSE, sparse=TRUE)
landY_test <- build.y(histFormula, data=land_test) %>% as.factor() %>% as.integer() - 1

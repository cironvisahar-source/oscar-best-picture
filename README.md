# Predicting Best Picture Winners

This repository contains an R-based statistical modelling project on Academy Awards Best Picture nominees from 1928 to 2024. The coursework brief asks for a logistic regression analysis, model selection, ROC-based evaluation, predicted probabilities for the 2025 contenders, and discussion of a more suitable alternative model for within-year competition. [page:1]

## Project overview

The project uses historical Oscar nominee data to estimate the probability that a nominated film wins Best Picture. The attached R script reads the Oscar dataset, constructs a binary response variable for winning, fits a full logistic regression model, performs backward elimination using AIC, evaluates the final model with ROC and AUC, and produces predicted probabilities for the 2025 nominees. [page:1][file:2]

## Coursework tasks

The assignment requires five core tasks:

- Fit the full logistic regression model, interpret one significant coefficient, and report its confidence interval. [page:1]
- Use a model-selection strategy taught in class to choose a final model and justify each inclusion or exclusion step. [page:1]
- Calculate the AUC of the final model, choose an optimal ROC threshold, and report sensitivity. [page:1]
- Predict the probability of winning for each current Best Picture contender, with probabilities summing to 1 for that year. [page:1]
- Research a more suitable model than standard logistic regression for this grouped outcome structure. [page:1]

## What the code does

According to the attached script, the analysis:

- Loads the Oscar dataset and prepares a binary outcome variable called `MPWin`. [file:2]
- Fits a full logistic regression model using many award, genre, rating, critic, and film-level predictors. [file:2]
- Uses repeated backward elimination with AIC to reduce the model to a final specification. [file:2]
- Reports a final model including predictors such as `Year`, `Dir`, `Ams`, `Edi`, `Mak`, `Dan`, `Gdr`, `Gd`, `PGA`, `DGA`, `Musical`, `Ebert`, `NSFC`, and `WR`. [file:2]
- Computes ROC performance and records an AUC of 0.9327 with sensitivity reported as 0.8854 at the selected threshold. [file:2]
- Normalises predicted probabilities across the 2025 nominees so they sum to 1 and identifies Anora as the top predicted winner in the script output. [file:2]

## Repository structure

A clean GitHub structure for this project could be:

```text
oscars-best-picture-model/
├── README.md
├── data/
│   ├── oscars.csv
│   └── oscarcodebook.csv
├── scripts/
│   └── SCoursework.R
├── outputs/
│   ├── figures/
│   └── tables/
└── report/
    └── final-coursework.pdf
```

If the dataset or assignment files come from a university platform, check whether they can be shared publicly before uploading them. The brief states that the submission is anonymous coursework distributed through Keats, so it is safer to upload only material you are permitted to publish. [page:1]

## Methods

The main modelling method is binary logistic regression, where each nominated film is treated as either a winner or non-winner. The script then applies backward elimination guided by AIC, followed by ROC analysis to assess classification performance. [file:2]

A useful extension for the written report is to explain why ordinary logistic regression is imperfect here: Best Picture nominees compete within the same year, so observations are not fully independent in the way the model assumes. The brief explicitly asks for an alternative model whose probabilities sum to 1 within each award year. [page:1]

## Suggested alternative model

A strong alternative to discuss is a conditional logistic model or a multinomial choice model for grouped yearly nominees. These approaches are better suited to competition within each Oscar year because they model relative winning probabilities among the nominees in the same set, which naturally supports probabilities summing to 1 within a year. [page:1]

## Tools

- R
- Base `glm()` for logistic regression [file:2]
- `pROC` for ROC curves and AUC calculation [file:2]
- Standard data-wrangling steps coded directly in the script [file:2]

## How to run

1. Place `oscars.csv` in your working directory or update the file path in the script. [page:1][file:2]
2. Open `SCoursework.R` in RStudio.
3. Install any required packages, especially `pROC`. [file:2]
4. Run the script from top to bottom to reproduce the model fitting, selection, ROC evaluation, and prediction steps. [file:2]

## Notes for GitHub

This README should describe the project in your own words rather than reproducing the coursework brief. A good public repository should focus on the research question, method, workflow, and key findings, while keeping the original assignment PDF separate unless sharing it is clearly allowed. [page:1]

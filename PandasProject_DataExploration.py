import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df=pd.read_csv(r"world_population.csv")
pd.set_option('display.max.columns',17)

pd.set_option('display.float_format', lambda x: '%.2f' % x)    #TO DISPLAY 2 DIGITS AFTER DECIMAL POINT

# print(df.info())

# print(df.describe())

# print(df.isnull().sum())     #NUMBER OF NULL VALUES IN EACH COLUMNS

# print(df.nunique())    #NUMBER OF UNIQUE VALUES IN EACHH COLUMNS



#SORTING BASED ON 2022 POPULATION & WORLD POPULATION PERCENTAGE
# print(df.sort_values(by='2022 Population').head())
# print(df.sort_values(by='2022 Population',ascending=False).head())
# print(df.sort_values(by='World Population Percentage',ascending=False).head())



#CORRELATION (How columns are correlated) using heatmap visualization
# Check data types
# print(df.dtypes)
#
# # Select only numeric columns
# df_numeric = df.select_dtypes(include=[float, int])
# #
# # # Print correlation matrix of numeric columns
# df_numeric.corr()
#
# sns.heatmap(df_numeric.corr(), annot=True)
# plt.show()




#GROUP BY CONTINENT AND ANALYSE ITS GROWTH RATE AND OTHER STUFFS



# Group by 'Continent' and calculate mean of numeric columns
# df_numeric_grouped = df.groupby('Continent').mean('2022 Population').sort_values(by='2022 Population', ascending=False)
# df3=df_numeric_grouped.transpose()
# print(df3)
# df3.plot()
# plt.show()


# df.boxplot()
# plt.show()


# #JUST RETURN THE COLUMNS WITH DATA TYPE NUMBERS AND IGNORE OTHERS
# print(df.select_dtypes(include='number'))



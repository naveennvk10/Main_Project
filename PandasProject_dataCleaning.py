import pandas as pd
import openpyxl

df = pd.read_excel(r"Customer Call List.xlsx")
pd.set_option('display.max.columns', 8)
df = df.drop_duplicates()

df = df.drop(columns='Not_Useful_Column')

df['Last_Name'] = df['Last_Name'].str.lstrip('...')
df['Last_Name'] = df['Last_Name'].str.lstrip('/')

df['Phone_Number'] = df['Phone_Number'].str.replace('[^a-zA-Z0-9]', '', regex=True)

df['Phone_Number'] = df['Phone_Number'].apply(lambda x: str(x))
df['Phone_Number'] = df['Phone_Number'].apply(lambda x: x[0:3] + '-' + x[3:6] + '-' + x[6:])

df['Phone_Number'] = df['Phone_Number'].replace('nan--', '')
df['Phone_Number'] = df['Phone_Number'].replace('Na--', '')

df[['Street_Address', 'State', 'Pincode']] = df['Address'].str.split(',', n=2, expand=True)

df['Paying Customer']=df['Paying Customer'].str.replace('Yes', 'Y')
df['Paying Customer']=df['Paying Customer'].str.replace('No', 'N')

df['Do_Not_Contact']=df['Do_Not_Contact'].str.replace('No', 'N')
df['Do_Not_Contact']=df['Do_Not_Contact'].str.replace('Yes', 'Y')


df=df.replace('N/a', '')
df=df.fillna('')

for x in df.index:
    if df.loc[x, 'Do_Not_Contact']=='Y':
        df.drop(x,inplace=True)

#To Delete Datas with donot contact = Y. And give proper index

for x in df.index:
    if df.loc[x, 'Do_Not_Contact']=='':
        df.drop(x,inplace=True)

df=df.reset_index(drop=True)

print(df)



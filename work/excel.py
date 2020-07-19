import openpyxl

workbook = openpyxl.load_workbook("c:/Users/Administrator/Desktop/abc.xlsx")
sheet = workbook['Sheet1']
for i in range(1, sheet.max_row):
    xy1 = 'A' + str(i)
    xy2 = 'B' + str(i)
    v1 = sheet[xy1].value
    v2 = sheet[xy2].value
    if v1 or v2:
        print(v1, v2)

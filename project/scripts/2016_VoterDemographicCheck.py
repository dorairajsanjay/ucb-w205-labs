# -*- coding: utf-8 -*-
"""
Created on Sun Apr 23 13:33:21 2017

@author: PC
"""

from tkinter import *
import pandas as pd

class Checkbar(Frame):
   def __init__(self, parent=None, picks=[], side=LEFT, anchor=W):
      Frame.__init__(self, parent)
      self.vars = []
      for pick in picks:
         var = IntVar()
         chk = Checkbutton(self, text=pick, variable=var)
         chk.pack(side=side, anchor=anchor, expand=YES)
         self.vars.append(var)
   def state(self):
      return map((lambda var: var.get()), self.vars)
if __name__ == '__main__':
   root = Tk()
   root.title("California Voting Demographics by County")
   frame_county = Frame(root)
   frame_county.pack(side = LEFT)
   frame_county2 = Frame(root)
   frame_county2.pack(side = LEFT)
   frame_denom = Frame(root)
   frame_denom.pack(side = LEFT)
   frame_gender = Frame(root)
   frame_gender.pack(side = LEFT)
   frame_ages = Frame(root)
   frame_ages.pack(side = LEFT)
   frame_parties = Frame(root)
   frame_parties.pack(side = LEFT)
   frame_methods = Frame(root)
   frame_methods.pack(side = RIGHT)
   counties1 = Checkbar(frame_county, ['Alameda', 'Alpine', 'Amador', 'Butte', 'Calaveras', 'Colusa', 'Contra Costa', 'Del Norte', 'El Dorado', 'Fresno', 'Glenn', 'Humboldt', 'Imperial', 'Inyo', 'Kern', 'Kings', 'Lake', 'Lassen', 'Los Angeles', 'Madera', 'Marin', 'Mariposa', 'Mendocino', 'Merced', 'Modoc', 'Mono', 'Monterey', 'Napa', 'Nevada'], side = TOP)
   counties2 = Checkbar(frame_county2, ['Orange', 'Placer', 'Plumas', 'Riverside', 'Sacramento', 'San Benito', 'San Bernardino', 'San Diego', 'San Francisco', 'San Joaquin', 'San Luis Obispo', 'San Mateo', 'Santa Barbara', 'Santa Clara', 'Santa Cruz', 'Shasta', 'Sierra', 'Siskiyou', 'Solano', 'Sonoma', 'Stanislaus', 'Sutter', 'Tehama', 'Trinity', 'Tulare', 'Tuolumne', 'Ventura', 'Yolo', 'Yuba'], side = TOP)
   denominators = Checkbar(frame_denom, ['% of Total Registered', '% of Total Voters', '% of Demographic Voting'], side = TOP)
   genders = Checkbar(frame_gender, ['No Breakdown', 'F', 'M'], side = TOP)
   ages = Checkbar(frame_ages, ['No Breakdown', '18-30', '30-40', '40-50', '50-60', '60-70', '70-80', '80+'], side = TOP)
   parties = Checkbar(frame_parties, ['No Breakdown', 'DEM', 'REP', 'AI', 'GRN', 'LIB', 'PF', 'NPP'], side = TOP)
   countylabel = Label(frame_county, text = "Counties")
   countylabel.pack()
   denomlabel = Label(frame_denom, text = "Denominators of Choice\nYou can only pick one\nOnly the last choice in the list will count")
   denomlabel.pack()
   genderlabel = Label(frame_gender, text = "Gender")
   genderlabel.pack()
   agelabel = Label(frame_ages, text = "Age Groups")
   agelabel.pack()
   partylabel = Label(frame_parties, text = "Political Partiies")
   partylabel.pack()
   methodslabel = Label(frame_methods, text = "Methods of Voting")
   methodslabel.pack()
   counties1.pack(side = TOP, fill=X)
   counties2.pack(fill=X)
   denominators.pack(fill=X)
   genders.pack(fill=X)
   ages.pack(fill=X)
   parties.pack(fill=X)   
   
   def allstates(): 
      print(list(counties1.state()), list(counties2.state()), list(denominators.state()), list(genders.state()), list(ages.state()), list(parties.state()))
   Button(root, text='Peek', command=allstates).pack(side=RIGHT)
   root.mainloop()
  
counties1_list = ['Alameda', 'Alpine', 'Amador', 'Butte', 'Calaveras', 'Colusa', 'Contra Costa', 'Del Norte', 'El Dorado', 'Fresno', 'Glenn', 'Humboldt', 'Imperial', 'Inyo', 'Kern', 'Kings', 'Lake', 'Lassen', 'Los Angeles', 'Madera', 'Marin', 'Mariposa', 'Mendocino', 'Merced', 'Modoc', 'Mono', 'Monterey', 'Napa', 'Nevada']
counties2_list = ['Orange', 'Placer', 'Plumas', 'Riverside', 'Sacramento', 'San Benito', 'San Bernardino', 'San Diego', 'San Francisco', 'San Joaquin', 'San Luis Obispo', 'San Mateo', 'Santa Barbara', 'Santa Clara', 'Santa Cruz', 'Shasta', 'Sierra', 'Siskiyou', 'Solano', 'Sonoma', 'Stanislaus', 'Sutter', 'Tehama', 'Trinity', 'Tulare', 'Tuolumne', 'Ventura', 'Yolo', 'Yuba']
denominators_list = ['_tcount', '_tvote', '_count']
genders_list = ['_n_', '_f_', '_m_']
ages_list = ['00', '18', '30', '40', '50', '60', '70', '80']
parties_list = ['npb_', 'dem_', 'rep_', 'aip_', 'grn_', 'lib_', 'pfp_', 'npp_']

counties_chosen = []
denominators_chosen = []
genders_chosen = []
ages_chosen = []
parties_chosen = []

print(len(list(denominators.state())))
print(list(denominators.state()))

for x in range(0, len(list(counties1.state()))):
    if list(counties1.state())[x] == 1:
        counties_chosen.append(counties1_list[x])
for x in range(0, len(list(counties2.state()))):
    if list(counties2.state())[x] == 1:
        counties_chosen.append(counties2_list[x])
for x in range(0, len(list(denominators.state()))):
    if list(denominators.state())[x] == 1:
        denominators_chosen.append(denominators_list[x])
for x in range(0, len(list(genders.state()))):
    if list(genders.state())[x] == 1:
        genders_chosen.append(genders_list[x])
for x in range(0, len(list(ages.state()))):
    if list(ages.state())[x] == 1:
        ages_chosen.append(ages_list[x])
for x in range(0, len(list(parties.state()))):
    if list(parties.state())[x] == 1:
        parties_chosen.append(parties_list[x])

if not genders_chosen:
    genders_chosen = ['_n_']
if not ages_chosen:
    ages_chosen = ['00']
if not parties_chosen:
    parties_chosen = ['npb_']
column_list = ['_f_aip_00_count', '_f_aip_00_vote', '_f_aip_18_count', '_f_aip_18_vote', '_f_aip_30_count', '_f_aip_30_vote', '_f_aip_40_count', '_f_aip_40_vote', '_f_aip_50_count', '_f_aip_50_vote', '_f_aip_60_count', '_f_aip_60_vote', '_f_aip_70_count', '_f_aip_70_vote', '_f_aip_80_count', '_f_aip_80_vote', '_f_dem_00_count', '_f_dem_00_vote', '_f_dem_18_count', '_f_dem_18_vote', '_f_dem_30_count', '_f_dem_30_vote', '_f_dem_40_count', '_f_dem_40_vote', '_f_dem_50_count', '_f_dem_50_vote', '_f_dem_60_count', '_f_dem_60_vote', '_f_dem_70_count', '_f_dem_70_vote', '_f_dem_80_count', '_f_dem_80_vote', '_f_grn_00_count', '_f_grn_00_vote', '_f_grn_18_count', '_f_grn_18_vote', '_f_grn_30_count', '_f_grn_30_vote', '_f_grn_40_count', '_f_grn_40_vote', '_f_grn_50_count', '_f_grn_50_vote', '_f_grn_60_count', '_f_grn_60_vote', '_f_grn_70_count', '_f_grn_70_vote', '_f_grn_80_count', '_f_grn_80_vote', '_f_lib_00_count', '_f_lib_00_vote', '_f_lib_18_count', '_f_lib_18_vote', '_f_lib_30_count', '_f_lib_30_vote', '_f_lib_40_count', '_f_lib_40_vote', '_f_lib_50_count', '_f_lib_50_vote', '_f_lib_60_count', '_f_lib_60_vote', '_f_lib_70_count', '_f_lib_70_vote', '_f_lib_80_count', '_f_lib_80_vote','_f_npb_00_count', '_f_npb_00_vote', '_f_npb_18_count', '_f_npb_18_vote', '_f_npb_30_count', '_f_npb_30_vote', '_f_npb_40_count', '_f_npb_40_vote', '_f_npb_50_count', '_f_npb_50_vote', '_f_npb_60_count', '_f_npb_60_vote', '_f_npb_70_count', '_f_npb_70_vote', '_f_npb_80_count', '_f_npb_80_vote', '_f_npp_00_count', '_f_npp_00_vote', '_f_npp_18_count', '_f_npp_18_vote', '_f_npp_30_count', '_f_npp_30_vote', '_f_npp_40_count', '_f_npp_40_vote', '_f_npp_50_count', '_f_npp_50_vote', '_f_npp_60_count', '_f_npp_60_vote', '_f_npp_70_count', '_f_npp_70_vote', '_f_npp_80_count', '_f_npp_80_vote', '_f_pfp_00_count', '_f_pfp_00_vote', '_f_pfp_18_count', '_f_pfp_18_vote', '_f_pfp_30_count', '_f_pfp_30_vote', '_f_pfp_40_count', '_f_pfp_40_vote', '_f_pfp_50_count', '_f_pfp_50_vote', '_f_pfp_60_count', '_f_pfp_60_vote', '_f_pfp_70_count', '_f_pfp_70_vote', '_f_pfp_80_count', '_f_pfp_80_vote', '_f_rep_00_count', '_f_rep_00_vote', '_f_rep_18_count', '_f_rep_18_vote', '_f_rep_30_count', '_f_rep_30_vote', '_f_rep_40_count', '_f_rep_40_vote', '_f_rep_50_count', '_f_rep_50_vote', '_f_rep_60_count', '_f_rep_60_vote', '_f_rep_70_count', '_f_rep_70_vote', '_f_rep_80_count', '_f_rep_80_vote', '_m_aip_00_count', '_m_aip_00_vote', '_m_aip_18_count', '_m_aip_18_vote', '_m_aip_30_count', '_m_aip_30_vote', '_m_aip_40_count', '_m_aip_40_vote', '_m_aip_50_count', '_m_aip_50_vote', '_m_aip_60_count', '_m_aip_60_vote', '_m_aip_70_count', '_m_aip_70_vote', '_m_aip_80_count', '_m_aip_80_vote', '_m_dem_00_count', '_m_dem_00_vote', '_m_dem_18_count', '_m_dem_18_vote', '_m_dem_30_count', '_m_dem_30_vote', '_m_dem_40_count', '_m_dem_40_vote', '_m_dem_50_count', '_m_dem_50_vote', '_m_dem_60_count', '_m_dem_60_vote', '_m_dem_70_count', '_m_dem_70_vote', '_m_dem_80_count', '_m_dem_80_vote', '_m_grn_00_count', '_m_grn_00_vote', '_m_grn_18_count', '_m_grn_18_vote', '_m_grn_30_count', '_m_grn_30_vote', '_m_grn_40_count', '_m_grn_40_vote', '_m_grn_50_count', '_m_grn_50_vote', '_m_grn_60_count', '_m_grn_60_vote', '_m_grn_70_count', '_m_grn_70_vote', '_m_grn_80_count', '_m_grn_80_vote', '_m_lib_00_count', '_m_lib_00_vote', '_m_lib_18_count', '_m_lib_18_vote', '_m_lib_30_count', '_m_lib_30_vote', '_m_lib_40_count', '_m_lib_40_vote', '_m_lib_50_count', '_m_lib_50_vote', '_m_lib_60_count', '_m_lib_60_vote', '_m_lib_70_count', '_m_lib_70_vote', '_m_lib_80_count', '_m_lib_80_vote', '_m_npb_00_count', '_m_npb_00_vote', '_m_npb_18_count', '_m_npb_18_vote', '_m_npb_30_count', '_m_npb_30_vote', '_m_npb_40_count', '_m_npb_40_vote', '_m_npb_50_count', '_m_npb_50_vote', '_m_npb_60_count', '_m_npb_60_vote', '_m_npb_70_count', '_m_npb_70_vote', '_m_npb_80_count', '_m_npb_80_vote', '_m_npp_00_count', '_m_npp_00_vote', '_m_npp_18_count', '_m_npp_18_vote', '_m_npp_30_count', '_m_npp_30_vote', '_m_npp_40_count', '_m_npp_40_vote', '_m_npp_50_count', '_m_npp_50_vote', '_m_npp_60_count', '_m_npp_60_vote', '_m_npp_70_count', '_m_npp_70_vote', '_m_npp_80_count', '_m_npp_80_vote', '_m_pfp_00_count', '_m_pfp_00_vote', '_m_pfp_18_count', '_m_pfp_18_vote', '_m_pfp_30_count', '_m_pfp_30_vote', '_m_pfp_40_count', '_m_pfp_40_vote', '_m_pfp_50_count', '_m_pfp_50_vote', '_m_pfp_60_count', '_m_pfp_60_vote', '_m_pfp_70_count', '_m_pfp_70_vote', '_m_pfp_80_count', '_m_pfp_80_vote', '_m_rep_00_count', '_m_rep_00_vote', '_m_rep_18_count', '_m_rep_18_vote', '_m_rep_30_count', '_m_rep_30_vote', '_m_rep_40_count', '_m_rep_40_vote', '_m_rep_50_count', '_m_rep_50_vote', '_m_rep_60_count', '_m_rep_60_vote', '_m_rep_70_count', '_m_rep_70_vote', '_m_rep_80_count', '_m_rep_80_vote', '_n_aip_00_count', '_n_aip_00_vote', '_n_aip_18_count', '_n_aip_18_vote', '_n_aip_30_count', '_n_aip_30_vote', '_n_aip_40_count', '_n_aip_40_vote', '_n_aip_50_count', '_n_aip_50_vote', '_n_aip_60_count', '_n_aip_60_vote', '_n_aip_70_count', '_n_aip_70_vote', '_n_aip_80_count', '_n_aip_80_vote', '_n_dem_00_count', '_n_dem_00_vote', '_n_dem_18_count', '_n_dem_18_vote', '_n_dem_30_count', '_n_dem_30_vote', '_n_dem_40_count', '_n_dem_40_vote', '_n_dem_50_count', '_n_dem_50_vote', '_n_dem_60_count', '_n_dem_60_vote', '_n_dem_70_count', '_n_dem_70_vote', '_n_dem_80_count', '_n_dem_80_vote', '_n_grn_00_count', '_n_grn_00_vote', '_n_grn_18_count', '_n_grn_18_vote', '_n_grn_30_count', '_n_grn_30_vote', '_n_grn_40_count', '_n_grn_40_vote', '_n_grn_50_count', '_n_grn_50_vote', '_n_grn_60_count', '_n_grn_60_vote', '_n_grn_70_count', '_n_grn_70_vote', '_n_grn_80_count', '_n_grn_80_vote', '_n_lib_00_count', '_n_lib_00_vote', '_n_lib_18_count', '_n_lib_18_vote', '_n_lib_30_count', '_n_lib_30_vote', '_n_lib_40_count', '_n_lib_40_vote', '_n_lib_50_count', '_n_lib_50_vote', '_n_lib_60_count', '_n_lib_60_vote', '_n_lib_70_count', '_n_lib_70_vote', '_n_lib_80_count', '_n_lib_80_vote', '_n_npb_18_count', '_n_npb_18_vote', '_n_npb_30_count', '_n_npb_30_vote', '_n_npb_40_count', '_n_npb_40_vote', '_n_npb_50_count', '_n_npb_50_vote', '_n_npb_60_count', '_n_npb_60_vote', '_n_npb_70_count', '_n_npb_70_vote', '_n_npb_80_count', '_n_npb_80_vote', '_n_npp_00_count', '_n_npp_00_vote', '_n_npp_18_count', '_n_npp_18_vote', '_n_npp_30_count', '_n_npp_30_vote', '_n_npp_40_count', '_n_npp_40_vote', '_n_npp_50_count', '_n_npp_50_vote', '_n_npp_60_count', '_n_npp_60_vote', '_n_npp_70_count', '_n_npp_70_vote', '_n_npp_80_count', '_n_npp_80_vote', '_n_pfp_00_count', '_n_pfp_00_vote', '_n_pfp_18_count', '_n_pfp_18_vote', '_n_pfp_30_count', '_n_pfp_30_vote', '_n_pfp_40_count', '_n_pfp_40_vote', '_n_pfp_50_count', '_n_pfp_50_vote', '_n_pfp_60_count', '_n_pfp_60_vote', '_n_pfp_70_count', '_n_pfp_70_vote', '_n_pfp_80_count', '_n_pfp_80_vote', '_n_rep_00_count', '_n_rep_00_vote', '_n_rep_18_count', '_n_rep_18_vote', '_n_rep_30_count', '_n_rep_30_vote', '_n_rep_40_count', '_n_rep_40_vote', '_n_rep_50_count', '_n_rep_50_vote', '_n_rep_60_count', '_n_rep_60_vote', '_n_rep_70_count', '_n_rep_70_vote', '_n_rep_80_count', '_n_rep_80_vote']
demos_chosen = []
for i in genders_chosen:
    for j in parties_chosen:
        for k in ages_chosen:
            for l in ['_vote', '_count']:
                demos_chosen.append(str(i+j+k+l))

full_demographic_check = [s for s in column_list if any(xs in s for xs in demos_chosen)]

print("You choose to look at the data for:", "\nCounties: ", counties_chosen, "\nDenominator: ", denominators_chosen, "\nGenders: ", genders_chosen, "\nAges: ", ages_chosen, "\nParties: ", parties_chosen)
full_csv = pd.read_csv('demo_final.csv')
full_frame = pd.DataFrame(full_csv)
full_frame = full_frame.set_index('countycode')
        
demo_frame = full_frame[[col for col in full_frame.columns if col in full_demographic_check]]
county_general = pd.read_csv('county_general.csv')
county_gen_df = pd.DataFrame(county_general)
county_gen_df = county_gen_df.set_index('countycode')
pre_calc_frame = pd.concat([county_gen_df, demo_frame], axis = 1)
county_select_frame = pre_calc_frame[pre_calc_frame['county'].isin(counties_chosen)]
print("These are the raw totals for each of the categories in your selected dataframe. Tcount is the total number of registered voters, Tvote is the total actual 2016 voters, and the subsequent variables are combinations of demographics. If you selected none for any of the demographics, then you may see 'n' (no gender specified), 'npb' (no party breakdown) or '00' (all ages). The suffixes of count and vote refer to the number of registered per demographic and the number who actually voted.\n")
print(county_select_frame)

print(denominators_chosen)

if denominators_chosen:
    if denominators_chosen == ['_tcount']:
        county_frame = county_select_frame['county']
        calculated_frame = [county_select_frame[county_select_frame.columns[3:]].div(county_select_frame['_tcount'], axis=0)]
        print(county_frame)
        print("\nThis will calculate the percentage of registered voters described by your choices compared to the full list of registered voters.\n")
        print(calculated_frame)
    elif denominators_chosen == ['_tvote']: 
        county_frame = county_select_frame['county']
        calculated_frame = [county_select_frame[county_select_frame.columns[3:]].div(county_select_frame['_tvote'], axis=0)]
        print(county_frame)
        print("\nThis will calculate the percentage of people who voted in the last election described by your choices compared to the full list people who actually voted.\n")
        print(calculated_frame)
    else:
        county_frame = county_select_frame['county']
        arr = county_select_frame.values
        calculated_frame = pd.DataFrame(arr[:,4::2] / arr[:,3::2], columns = county_select_frame.columns[4::2])
        print(county_frame)
        print("This will calculate the percentage of people described by your choices that voted in the last election")
        print(calculated_frame)
else:
    print("You didn't pick a denominator.")

Select t.countycode, t.partycode, (count(t.registrantid)/s.count_value_sum)/w.percentage as county_v_natl_pct
FROM voter_grand t
JOIN (SELECT countycode, count(registrantid) AS count_value_sum 
FROM voter_grand
GROUP BY countycode) s
ON s.countycode = t.countycode 
JOIN (SELECT u.partycode, count(u.registrantid)/v.count_value_sum as percentage
FROM voter_grand u
JOIN
(SELECT count(registrantid) AS count_value_sum 
FROM voter_grand) v
WHERE u.partycode IN ("DEM", "GRN", "LIB", "REP")
GROUP BY u.partycode, v.count_value_sum) w
ON w.partycode = t.partycode
WHERE t.partycode IN ("DEM", "REP", "GRN", "LIB")
GROUP BY t.countycode, t.partycode, s.count_value_sum, w.percentage
ORDER BY county_v_natl_pct DESC
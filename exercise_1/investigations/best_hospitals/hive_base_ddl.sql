DROP TABLE hospital_quality_consolidated

CREATE TABLE hospital_quality_consolidated 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
AS
select new_surveys_responses.provider_id as provider_id,new_surveys_responses.hcahps_base_score as hcahps_base_score,new_surveys_responses.hcahps_consistency_score as hcahps_consistency_score, all_measures.eff_score, all_measures.readm_score 
from new_surveys_responses 
join 
(
select new_effective_care.provider_id as provider_id,sum(new_effective_care.score) as eff_score, sum(new_readmissions.score) as readm_score from new_readmissions join new_effective_care on (new_readmissions.provider_id=new_effective_care.provider_id) group by new_effective_care.provider_id 
) all_measures 
where (new_surveys_responses.provider_id=all_measures.provider_id);

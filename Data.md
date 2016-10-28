# Notes on the variables

Variable name                       | Variable description                                                                                         | Source
:---------------------------------- | :----------------------------------------------------------------------------------------------------------- | :-----------------------------
id                                  | unique id for a speech                                                                                       |
url_rep_id                          | unique id for representatives in online urls (NA for presidents)                                             | Scraped from www.stortinget.no
rep_id                              | unique id for representatives from API (NA for presidents)                                                   | Storting API
rep_first_name                      | first name                                                                                                   | Storting API
rep_last_name                       | last name                                                                                                    | Storting API
rep_name                            | full name                                                                                                    | Storting API
rep_from                            | start of the mandate (NA for presidents)                                                                     | Scraped from www.stortinget.no
rep_to                              | end of mandate (NA for presidents)                                                                           | Scraped from www.stortinget.no
rep_type                            | type of representative (representant, vararepresentant), NA for all non representatives or elected ministers | Scraped from www.stortinget.no
county                              | county of provenance                                                                                         | Storting API
list_number                         | position on the party list at the last election                                                              | Scraped from www.stortinget.no
party_id                            | unique id for a party                                                                                        | Storting API
party_name                          | full name of the party                                                                                       | Storting API
party_role                          | parliament role of the party (cabinet, opposition, support), NA for presidents                               | Søyland (2016)
party_seats                         | number of seats in parliament for the speaker's party                                                        | Søyland (2016)
cabinet_short                       | pet name for the current cabinet (also usable as an id)                                                      | Søyland (2016)
cabinet_start                       | start date of the cabinet                                                                                    | Søyland (2016)
cabinet_composition                 | composition of the cabinet (Coalition, Single-party)                                                         | Søyland (2016)
cabinet_end                         | end date of the cabinet                                                                                      | Søyland (2016)
rep_gender                          | gender                                                                                                       | Storting API
rep_birth                           | date of birth                                                                                                | Storting API
rep_death                           | date of death                                                                                                | Storting API
parl_period                         | election cycle                                                                                               | Storting API
parl_size                           | total amount of seats in parliament                                                                          | Scraped from www.stortinget.no
party_seats_lagting                 | party seats in the upper chamber (when applicable)                                                           | Scraped from www.stortinget.no
party_seats_odelsting               | party seats in the lower chamber (when applicable)                                                           | Scraped from www.stortinget.no
com_member                          | the committees the representative was a member of this parliamentary period                                  | Scraped from www.stortinget.no
com_date                            | the dates that the representative was member of the committees of `com_member`                               | Scraped from www.stortinget.no
com_role                            | the role the representative had in the corresponding committee to `com_member`                               | Scraped from www.stortinget.no
debate_reference                    | where to find the debate                                                                                     | Storting API
case_id                             | the id of the case                                                                                           | Storting API
debate_title                        | title of the debate                                                                                          | Storting API
debate_subject                      | subject of the debate                                                                                        | Storting API
debate_type                         | type of debate (question/interpellation etc)                                                                 | Storting API
proposition_id                      | id of proposition                                                                                            | Storting API
proposition_text                    | proposition text                                                                                             | Storting API
document_group                      | underlying debate document group (proposisjon/melding etc)                                                   | Storting API
document_subject_short              | short subject description of document                                                                        | Storting API
decision_short                      | short description of decision made on the case under debate                                                  | Storting API
document_note                       | any notes attached to the underlying document of debate                                                      | Storting API
case_source_id                      | source id for the case                                                                                       | Storting API
case_chair_id                       | representative id for the chair of the case                                                                  | Storting API
case_type                           | type of case                                                                                                 | Storting API
decision_text                       | description of decision on the case                                                                          | Storting API
question_number                     | for questions, the question number                                                                           | Storting API
question_from_id                    | for questions, who asked the question (rep_id)                                                               | Storting API
question_to_id                      | for questions, who the question was asked to (rep_id)                                                        | Storting API
question_answered_by_id             | for questions, who answered the question (rep_id)                                                            | Storting API
question_answered_by_ministry_id    | for questions, the ministry the answering minister is under (id)                                             | Storting API
question_answered_by_minister_title | for questions, the ministry the answering minister is under (title)                                          | Storting API
subject_ids                         | id of the subjects under debate                                                                              | Storting API
subject_names                       | names of the subjects under debate                                                                           | Storting API
is_main_subject                     | is this the main subject?                                                                                    | Storting API
main_subject_id                     | id of the main subject                                                                                       | Storting API
subject_committee_id                | committee for this subject (id)                                                                              | Storting API
subject_committee_name              | committee for this subject (name)                                                                            | Storting API
agenda_case_number                  | the debates number on this day's agenda                                                                      | Storting API
agenda_case_reference               | reference to the case (from agenda data)                                                                     | Storting API
agenda_case_text                    | text for the case (from agenda data)                                                                         | Storting API
agenda_case_type                    | type of case (from agenda data)                                                                              | Storting API
agenda_number                       | the agenda number of this meeting                                                                            | Storting API
meeting_id                          | meeting id (to match meeting data from API)                                                                  | Storting API
procedure_id                        | all procedures the debate has gone through (id)                                                              | Storting API
procedure_name                      | all procedures the debate has gone through (name)                                                            | Storting API
procedure_stepnumber                | all procedures the debate has gone through (step number)                                                     | Storting API
publication_export_id               | publication export id for underlying case                                                                    | Storting API
publication_link_text               | publication text for underlying case                                                                         | Storting API
publication_link_url                | publication url for underlying case                                                                          | Storting API
publication_type                    | publication type for underlying case                                                                         | Storting API
publication_undertype               | publication under type for underlying case                                                                   | Storting API
related_case_id                     | id of related cases                                                                                          | Storting API
related_case_type                   | type of related cases                                                                                        | Storting API
related_case_title_short            | short titles of related cases                                                                                | Storting API
keyword                             | One word keyword for debate                                                                                  | Scraped from www.stortinget.no
keywords                            | all keywords for debate                                                                                      | Storting API
nob_nno                             | language identifier (bokmål/nynorsk)                                                                         | langid.py
transcript                          | a date variable that distiguish day and night meetings                                                       | holderdeord
order                               | speech order in a given day                                                                                  | holderdeord
time                                | timestamp of the speech                                                                                      | holderdeord
session                             | parliament session                                                                                           | holderdeord
date                                | date of the speech                                                                                           | holderdeord
title                               | title (representative, president, minister etc)                                                              | holderdeord
text                                | the speech                                                                                                   | holderdeord

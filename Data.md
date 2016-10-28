# Data sources
The data are gathered from various sources. Most come from [Stortinget's own API](https://data.stortinget.no), and of these seven were structured by [Holder de ord](https://www.holderdeord.no/portal) (see last seven variables of the table below). Additionally, severeal variables were scraped from the .html of various places on [Stortingets web page](https://stortinget.no). Variables on the cabinets and ministers are based on [Søyland (2016)](TBA)

# Variable description

| Variable name                       | Variable description                                                                                         | Source |
|:------------------------------------|:-------------------------------------------------------------------------------------------------------------|:-------|
| id                                  | unique id for a speech                                                                                       | |
| url_rep_id                          | unique id for representatives in online urls (NA for presidents)                                             | https://www.stortinget.no/ |
| rep_id                              | unique id for representatives from API (NA for presidents)                                                   | https://data.stortinget.no |
| rep_first_name                      | first name                                                                                                   | https://data.stortinget.no |
| rep_last_name                       | last name                                                                                                    | https://data.stortinget.no |
| rep_name                            | full name                                                                                                    | https://data.stortinget.no |
| rep_from                            | start of the mandate (NA for presidents)                                                                     | https://www.stortinget.no |
| rep_to                              | end of mandate (NA for presidents)                                                                           | https://www.stortinget.no |
| rep_type                            | type of representative (representant, vararepresentant), NA for all non representatives or elected ministers | https://www.stortinget.no |
| county                              | county of provenance                                                                                         | https://data.stortinget.no |
| list_number                         | position on the party list at the last election                                                              | https://www.stortinget.no/ |
| party_id                            | unique id for a party                                                                                        | https://data.stortinget.no |
| party_name                          | full name of the party                                                                                       | https://data.stortinget.no |
| party_role                          | parliament role of the party (cabinet, opposition, support), NA for presidents                               | Søyland (2016) |
| party_seats                         | number of seats in parliament for the speaker's party                                                        | Søyland (2016) |
| cabinet_short                       | pet name for the current cabinet (also usable as an id)                                                      | Søyland (2016) |
| cabinet_start                       | start date of the cabinet                                                                                    | Søyland (2016) |
| cabinet_composition                 | composition of the cabinet (Coalition, Single-party)                                                         | Søyland (2016) |
| cabinet_end                         | end date of the cabinet                                                                                      | Søyland (2016) |
| rep_gender                          | gender                                                                                                       | https://data.stortinget.no |
| rep_birth                           | date of birth                                                                                                | https://data.stortinget.no |
| rep_death                           | date of death                                                                                                | https://data.stortinget.no |
| parl_period                         | election cycle                                                                                               | https://data.stortinget.no |
| parl_size                           | total amount of seats in parliament                                                                          | https://www.stortinget.no |
| party_seats_lagting                 | party seats in the upper chamber (when applicable)                                                           | https://www.stortinget.no |
| party_seats_odelsting               | party seats in the lower chamber (when applicable)                                                           | https://www.stortinget.no |
| com_member                          | the committees the representative was a member of this parliamentary period                                  | https://www.stortinget.no |
| com_date                            | the dates that the representative was member of the committees of `com_member`                               | https://www.stortinget.no |
| com_role                            | the role the representative had in the corresponding committee to `com_member`                               | https://www.stortinget.no |
| debate_reference                    | where to find the debate                                                                                     | https://data.stortinget.no |
| case_id                             | the id of the case                                                                                           | https://data.stortinget.no |
| debate_title                        | title of the debate                                                                                          | https://data.stortinget.no |
| debate_subject                      | subject of the debate                                                                                        | https://data.stortinget.no |
| debate_type                         | type of debate (question/interpellation etc)                                                                 | https://data.stortinget.no |
| proposition_id                      | id of proposition                                                                                            | https://data.stortinget.no |
| proposition_text                    | proposition text                                                                                             | https://data.stortinget.no |
| document_group                      | underlying debate document group (proposisjon/melding etc)                                                   | https://data.stortinget.no |
| document_subject_short              | short subject description of document                                                                        | https://data.stortinget.no |
| decision_short                      | short description of decision made on the case under debate                                                  | https://data.stortinget.no |
| document_note                       | any notes attached to the underlying document of debate                                                      | https://data.stortinget.no |
| case_source_id                      | source id for the case                                                                                       | https://data.stortinget.no |
| case_chair_id                       | representative id for the chair of the case                                                                  | https://data.stortinget.no |
| case_type                           | type of case                                                                                                 | https://data.stortinget.no |
| decision_text                       | description of decision on the case                                                                          | https://data.stortinget.no |
| question_number                     | for questions, the question number                                                                           | https://data.stortinget.no |
| question_from_id                    | for questions, who asked the question (rep_id)                                                               | https://data.stortinget.no |
| question_to_id                      | for questions, who the question was asked to (rep_id)                                                        | https://data.stortinget.no |
| question_answered_by_id             | for questions, who answered the question (rep_id)                                                            | https://data.stortinget.no |
| question_answered_by_ministry_id    | for questions, the ministry the answering minister is under (id)                                             | https://data.stortinget.no |
| question_answered_by_minister_title | for questions, the ministry the answering minister is under (title)                                          | https://data.stortinget.no |
| subject_ids                         | id of the subjects under debate                                                                              | https://data.stortinget.no |
| subject_names                       | names of the subjects under debate                                                                           | https://data.stortinget.no |
| is_main_subject                     | is this the main subject?                                                                                    | https://data.stortinget.no |
| main_subject_id                     | id of the main subject                                                                                       | https://data.stortinget.no |
| subject_committee_id                | committee for this subject (id)                                                                              | https://data.stortinget.no |
| subject_committee_name              | committee for this subject (name)                                                                            | https://data.stortinget.no |
| agenda_case_number                  | the debates number on this day's agenda                                                                      | https://data.stortinget.no |
| agenda_case_reference               | reference to the case (from agenda data)                                                                     | https://data.stortinget.no |
| agenda_case_text                    | text for the case (from agenda data)                                                                         | https://data.stortinget.no |
| agenda_case_type                    | type of case (from agenda data)                                                                              | https://data.stortinget.no |
| agenda_number                       | the agenda number of this meeting                                                                            | https://data.stortinget.no |
| meeting_id                          | meeting id (to match meeting data from API)                                                                  | https://data.stortinget.no |
| procedure_id                        | all procedures the debate has gone through (id)                                                              | https://data.stortinget.no |
| procedure_name                      | all procedures the debate has gone through (name)                                                            | https://data.stortinget.no |
| procedure_stepnumber                | all procedures the debate has gone through (step number)                                                     | https://data.stortinget.no |
| publication_export_id               | publication export id for underlying case                                                                    | https://data.stortinget.no |
| publication_link_text               | publication text for underlying case                                                                         | https://data.stortinget.no |
| publication_link_url                | publication url for underlying case                                                                          | https://data.stortinget.no |
| publication_type                    | publication type for underlying case                                                                         | https://data.stortinget.no |
| publication_undertype               | publication under type for underlying case                                                                   | https://data.stortinget.no |
| related_case_id                     | id of related cases                                                                                          | https://data.stortinget.no |
| related_case_type                   | type of related cases                                                                                        | https://data.stortinget.no |
| related_case_title_short            | short titles of related cases                                                                                | https://data.stortinget.no |
| keyword                             | One word keyword for debate                                                                                  | https://stortinget.no |
| keywords                            | All keywords for debate                                                                                      | https://data.stortinget.no |
| language                             | language identifier (bokmål/nynorsk)                                                                        | langid.py |
| transcript                          | a date variable that distiguish day and night meetings                                                       | https://data.stortinget.no (via holderdeord) |
| order                               | speech order in a given day                                                                                  | https://data.stortinget.no (via holderdeord) |
| time                                | timestamp of the speech                                                                                      | https://data.stortinget.no (via holderdeord) |
| session                             | parliament session                                                                                           | https://data.stortinget.no (via holderdeord) |
| date                                | date of the speech                                                                                           | https://data.stortinget.no (via holderdeord) |
| title                               | title (representative, president, minister etc)                                                              | https://data.stortinget.no (via holderdeord) |
| text                                | the speech                                                                                                   | https://data.stortinget.no (via holderdeord) |

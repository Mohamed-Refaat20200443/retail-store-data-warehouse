Retail Store Data Warehouse (Project DWS)

A full end-to-end Data Warehouse project built for a retail store, covering the complete lifecycle from OLTP database design to a dimensional Data Warehouse (Star & Snowflake schemas) with ETL pipelines and analytical SQL queries.

📌 Project Overview

This project simulates a real-world Business Intelligence workflow for a Retail Store, starting from a transactional (OLTP) database and evolving it into a fully structured Data Warehouse (DWS) ready for reporting and analysis.

The work is organized into 9 progressive phases, each documented separately.

🗂️ Project Phases
Phase	Description
Phase 1	Initial project proposal / requirements documentation
Phase 2	Retail Store operational database design — Create, Insert, Update, Delete operations (with screenshots)
Phase 3	Database implementation & queries (Retail_Store_Database)
Phase 4	Additional SQL queries and refinements (SQLQuery2.sql)
Phase 5	Data Warehouse design — Star Schema & Snowflake Schema diagrams
Phase 6	Data Warehouse implementation (Retail_Store_DWS)
Phase 7	ETL process — Transferring data from the operational database to the Data Warehouse
Phase 8	Data Warehouse refinements and documentation
Phase 9	Final analytical queries on the Data Warehouse (Queries Retail_Store_DWS)

Final deliverable: Retail_Store_Data_Warehouse_Presentation.pptx — a summary presentation of the entire project.

🛠️ Tools & Technologies
Microsoft SQL Server / SSMS — database & data warehouse implementation
T-SQL — schema creation, ETL scripts, and analytical queries
Star Schema & Snowflake Schema — dimensional modeling techniques
Microsoft Word / OpenOffice — project documentation (.docx / .odt)
PowerPoint — final project presentation
📁 Repository Structure
Project DWS/
├── Phase 1/                  # Project proposal
├── Phase 2/                  # OLTP database design (CRUD)
├── Phase 3/                  # Database implementation
├── Phase 4/                  # SQL queries
├── phase 5/                  # DWS design (Star/Snowflake schema)
├── phase 6/                  # DWS implementation
├── Phase 7/                  # ETL (Database → DWS)
├── Phase 8/                  # DWS refinements
├── Phase 9/                  # Final analytical queries
└── Retail_Store_Data_Warehouse Presentation.pptx
🚀 How to Use
Restore the operational database using the backup file in Phase 3/Retail_Store_Database.
Restore the Data Warehouse using the backup file in phase 6/Retail_Store_DWS (or Phase 7).
Run the ETL scripts in Phase 7 to populate the Data Warehouse from the source database.
Run the analytical queries in Phase 9 against the Data Warehouse to generate reports.
📊 Data Model

The Data Warehouse follows dimensional modeling best practices with:

A Star Schema for simplified, query-optimized reporting.
A Snowflake Schema for normalized dimension tables.

See phase 5/DataWarehouse Design.docx and the accompanying diagrams for full details.

📄 License


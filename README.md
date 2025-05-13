# Pokemon-Data-Analytics-Project
## Project Highlights

**Python**
- Web Scraping: Scraped dynamically loaded websites using selenium and requests

- Data Processing: Combined for / while loops, try-except blocks, list comprehensions, and pandas DataFrames

- Optimized Code: Used ternary operators and regular expressions to clean and transform data

- Data Manipulation: Reorganized and aggregated scraped data with pandas for analysis

**MySQL**
- Complex Queries: Wrote queries with 100+ lines, merging CTEs, CASE statements, and unions to improve efficiency in joining all 9 Pokémon generation tables

- Advanced Analytics: Applied window functions (RANK, LEAD) with CTEs to compare cross-generation Pokémon stats

- Tier Analysis: Identified most prevalent type/ability in tiers using window and aggregate functions

- Classification: Used table joins and CTEs to classify Pokémon as new or existing

- Performance Metrics: Calculated stat differences between new and old Pokémon

**Tableau**
- Interactive Dashboards: Built dashboards that respond to generation selection

- LODs & Benchmarks: Used LOD expressions to compare statistical percentage differences between high-tier Pokémon

- Meta Analysis:
  - Identified stats bench mark and top types/abilities per meta tier

  - Compared average stats of new vs. existing Pokemon

  - Uncovered trends of new Pokemon consistently outperforming existing ones in average stats, especially in speed

  - Analyzed compared how often new vs. existing Pokemon are placed in high tiers

  - Showcased statistical balance patches from Gen 1 to Gen 9 to understand evolving game meta
---
## Showcase
**Unprocessed data set**
- ![image](https://github.com/user-attachments/assets/5aab5c99-bdaf-49b8-8980-39ec60a90c7a)  
  - an example of the original data set for one of the nine Pokemon generations
---
**MySQL Transformations**  
- ![image](https://github.com/user-attachments/assets/3aee4ddc-612c-4bf3-956c-e627e88d38b4)  
  - all 9 Pokemon generation tables merged together  
- ![image](https://github.com/user-attachments/assets/725ef7f9-291c-4e62-a457-fa3cbd3d0efb)  
  - table showing Pokemon stats from their original release to the most recent generation  
- ![image](https://github.com/user-attachments/assets/818ca996-40ec-407d-a993-9f66e5893f4d)  
  - stats comparison of new released and existing pokemon of their respective generation  

**Tableau Visualizations**
- ![image](https://github.com/user-attachments/assets/971a7774-82cc-4c33-bed3-b885b3af4a69)  
  - an overview of stats bench marks and pokemon demographic for specific tiers of a selected generation
- ![image](https://github.com/user-attachments/assets/4e33b8f1-7a68-4fd6-b088-b27ce5155808)  
  - stats comparison of new released vs. existing pokemon, as well as a trend line graphing meta development
- ![image](https://github.com/user-attachments/assets/7147647d-7764-498f-b432-3c02c1ee080f)  
  - how much of new released vs. existing pokemon are placed in high-tiers
---
## Key Takeaways
- Pokemon from the DP (4th) gen are especially powerful in the meta, dominating the top division for all of the generations from its release except for the SS (8th) gen
- The trend for meta development always revolve around strong attackers. ATK and SPA are always the most outstanding stat, next to SPE.
- From gen DP (4th) on-wards, new released pokemons always have higher overall stats, suggesting that meta development will be favoured towards new pokemons
- The % of new pokemons are placed in top meta tiers at a higher rate than older pokemons. Particularly in gen DP (4th) and SS(8th), new pokemons are placed in top meta almost 2x as frequent as older ones.
---
## Contact
If you want to discuss this project or collaborate, connect with me:  
Email: jackliao2314@gmail.com






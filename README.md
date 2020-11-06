# Hi everyone!
This script will help you learn how to build/construct the phylogenetic tree 
# And
how to code some simple command line for building the tree base on the tools which name's R-studio
# Now let's do it!
Before handshake for the job, please installing R software (link as below)
# R-base and R-studio
Lastest R-base version: https://cran.r-project.org/bin/windows/base/<br/>
Latest R-studio version: https://rstudio.com/products/rstudio/download/
# Choose platform installing in your laptop
# If Ubuntu/Linux 
Install with command line: sudo apt install r-base<br/>
Type "R" to open sofware<br/>
<img src="https://user-images.githubusercontent.com/51614765/98063834-87091300-1e83-11eb-815c-3c4d454967d1.png" width="30%"></img> 
# Remember to fix your own path when using these scripts 
Part1: Processing and alignment fasta file<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/aliprocess.r<br/>
source("aliprocess.r")<br/>
Part2: Find the best modeltest<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/model.r<br/>
source("model.r")<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/fix-tree-by-hand<br/>
bash fix-tree-by-hand<br/>
Part3: Building the phylogenetic tree<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/tree-by-hand.r<br/>
source("tree-by-hand.r")<br/>
# Video tutorial
http://www.viewpure.com/QS<br/>
Password unlock by <br/>
gmail: sangcnsh.ntu@gmail.com <br/>
Zalo: +84975359004<br/>
# If Windows 
# Step1: Open R-studio<br/>
<img src="https://user-images.githubusercontent.com/51614765/98062932-8a030400-1e81-11eb-9902-6247af9477f2.png" width="30%"></img><br/>
The interface includes 4 regions <br/>
1. Code editor <br/>
2. Data container and variables <br/>
3. Command line <br/>
4. Help <br/>
# Step2: In command line region: <br/>
Type: getwd()    -----  This is the location folder to contain your data <br/>
# Step3: Create fasta file format and save file name filename.txt <br/>
Using Notepad++ <br/>
Replace gap '-' into 'N' <br/>
Replace space ' ' into '_' <br/>
<img src="https://user-images.githubusercontent.com/51614765/98324187-2cf08500-201e-11eb-97f8-7893756c126f.png" width="15%"></img> <br/>
# Step4: Alignment<br/>
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/alignment_window.r <br/>
Choose filename.txt from new window tab<br/>
<img src="https://user-images.githubusercontent.com/51614765/98324187-2cf08500-201e-11eb-97f8-7893756c126f.png" width="15%"></img> <img src="https://user-images.githubusercontent.com/51614765/98324248-53162500-201e-11eb-95c9-80e46f4e7399.png" width="15%"></img> <br/>
output file is gonna be save into your folder of Step2 <br/>
# Step5: Processing <br/>
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/Processing_alignment.r <br/>
Choose filename.txt from new window tab<br/>
<img src="https://user-images.githubusercontent.com/51614765/98324986-4bf01680-2020-11eb-97b8-9aa3e537f3e8.png" width="15%"></img> <img src="https://user-images.githubusercontent.com/51614765/98324985-4a265300-2020-11eb-9145-d7eb0b55c1c9.png" width="15%"></img> <br/>
output file is gonna be save into your folder of Step2 <br/>
# Step6: Make equal sequence (Cutting head and tail) <br/>
Open Bioedit<br/>
In mode part, change to edit for repairing sequence
<img src="https://user-images.githubusercontent.com/51614765/98325696-ff0d3f80-2021-11eb-85e5-86a45ecad1cf.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325711-046a8a00-2022-11eb-8e4c-f865d5253cd1.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325719-0896a780-2022-11eb-9ed8-2d48167a9fea.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325726-0b919800-2022-11eb-90cb-b49f19f2566f.png" width="23%"></img> <br/>
# Step7: Modeltest (Finding the best model for building tree)





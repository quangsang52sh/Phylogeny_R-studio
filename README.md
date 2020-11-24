# Hi everyone!
I am very glad to share with you how to build/construct the phylogenetic tree and<br/>
how to use my script to write some simple command lines for building the tree based on the tools which name is R-studio
# Now let's do it!
Before entering the jobs, please installing R software (link as below), If the software is already installed, skip it. 
# R-base and R-studio
Lastest R-base version: https://cran.r-project.org/bin/windows/base/<br/>
Latest R-studio version: https://rstudio.com/products/rstudio/download/
# Choose platform installing in your laptop
# If Ubuntu/Linux (3 steps)
Install with command line: sudo apt install r-base<br/>
Type "R" to open sofware<br/>
<img src="https://user-images.githubusercontent.com/51614765/98063834-87091300-1e83-11eb-815c-3c4d454967d1.png" width="30%"></img> 
# (Warning) Remember to fix your own path when using these scripts 
# Step1: Processing and alignment fasta file<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/aliprocess.r<br/>
source("aliprocess.r")<br/>
# Step2: Find the best modeltest<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/model.r<br/>
source("model.r")<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/fix-tree-by-hand<br/>
bash fix-tree-by-hand.sh<br/>
# Step3: Building the phylogenetic tree<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/tree-by-hand.r<br/>
source("tree-by-hand.r")<br/>
# Video tutorial (For linux)
http://www.viewpure.com/QS<br/>
Password unlock by <br/>
gmail: sangcnsh.ntu@gmail.com <br/>
Zalo: +84975359004<br/>
# If Windows (9 steps)
# Notifications
If you have already created the fasta file and processed (making equal sequence) you should start at step 7 onwards<br/> 
If not, you must to start at step 1 onwards<br/>
# Step1: Open R-studio<br/>
<img src="https://user-images.githubusercontent.com/51614765/98062932-8a030400-1e81-11eb-9902-6247af9477f2.png" width="30%"></img><br/>
The interface includes 4 regions <br/>
1. Code editor <br/>
2. Data container and variables <br/>
3. Command line <br/>
4. Help, files and results <br/>
# Step2: In command line region: <br/>
Type: getwd()    -----  This is the location folder to contain your data <br/>
Results here "C:/Users/PC/Documents" <br/>
# Step3: Create fasta file format and save file name filename.txt <br/>
It will easy when you are using Notepad++ to format data (Recommended) <br/>
Free download here: https://notepad-plus-plus.org/downloads/<br/>
Open "filename.txt" by notepad++<br/>
Replace gap '-' into 'N' <br/>
Replace space ' ' into '_' <br/>
<img src="https://user-images.githubusercontent.com/51614765/98324187-2cf08500-201e-11eb-97f8-7893756c126f.png" width="15%"></img> <br/>
# Step4: Alignment<br/>
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/alignment_window.r <br/>
Choose "filename.txt" from new window tab<br/>
<img src="https://user-images.githubusercontent.com/51614765/98324187-2cf08500-201e-11eb-97f8-7893756c126f.png" width="15%"></img> <img src="https://user-images.githubusercontent.com/51614765/98324248-53162500-201e-11eb-95c9-80e46f4e7399.png" width="15%"></img> <br/>
Output file will gonna be saved into your folder of Step2 <br/>
# Step5: Processing <br/>
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/Processing_alignment.r <br/>
Choose "alignment_sequence.fasta" from new window tab<br/>
<img src="https://user-images.githubusercontent.com/51614765/98324986-4bf01680-2020-11eb-97b8-9aa3e537f3e8.png" width="15%"></img> <img src="https://user-images.githubusercontent.com/51614765/98324985-4a265300-2020-11eb-9145-d7eb0b55c1c9.png" width="15%"></img> <br/>
output file is gonna be save into your folder of Step2 <br/>
# Step6: Make equal sequence (Cutting head and tail) <br/>
Open Bioedit<br/>
In mode part, change to edit for repairing sequence<br/>
<img src="https://user-images.githubusercontent.com/51614765/98325696-ff0d3f80-2021-11eb-85e5-86a45ecad1cf.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325711-046a8a00-2022-11eb-8e4c-f865d5253cd1.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325719-0896a780-2022-11eb-9ed8-2d48167a9fea.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98325726-0b919800-2022-11eb-90cb-b49f19f2566f.png" width="23%"></img> <br/>
# Step7: Modeltest (Finding the best model for building tree)
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/model_window.r<br/>
Choose "processing_alignment.fasta" from new window tab<br/>
<img src="https://user-images.githubusercontent.com/51614765/98326969-18fc5180-2025-11eb-8d25-c6b0fa81aee8.png" width="23%"></img> <img src="https://user-images.githubusercontent.com/51614765/98326976-1e599c00-2025-11eb-9f37-7637da31f885.png" width="23%"></img> <br/>
Choose min AIC value <br/>
<img src="https://user-images.githubusercontent.com/51614765/98326982-21ed2300-2025-11eb-8c5c-455f5a4cad0a.png" width="23%"></img> <br/>
Finding the best model in output model.txt by notepad++ <br/>
<img src="https://user-images.githubusercontent.com/51614765/98326992-2580aa00-2025-11eb-87f7-51422d6b7c45.png" width="23%"></img> <br/>
Output "model.txt" will be saved in folder of Step2
# Step8: Building the phylogenetic tree
Copy script from this link and paste in Command line region<br/>
https://github.com/quangsang52sh/Phylogeny_R-studio/blob/main/tree_by_hand_window.r<br/>
Rename the line "fix here" with the best model you are choosing in Step 7 <br/>
<img src="https://user-images.githubusercontent.com/51614765/98494978-c911ca80-2270-11eb-875f-084b306881d3.png" width="15%"></img> <br/>
Relaxing and drinking coffee for a while :D <br/>
It will take the times depending on your data <br/>
<img src="https://user-images.githubusercontent.com/51614765/98495064-f1012e00-2270-11eb-820b-0254be031964.png" width="15%"></img> <br/>
The phylogenetic tree will temporarily illustrate in "help and results" region if you have done (see step1)<br/>
<img src="https://user-images.githubusercontent.com/51614765/98495070-f3638800-2270-11eb-9db5-8603fb518e32.png" width="15%"></img> <br/>
Looking detail your model by the command line "your_model" <br/>
<img src="https://user-images.githubusercontent.com/51614765/98495729-6e796e00-2272-11eb-8893-1b024347232b.png" width="15%"></img> <br/>
Output "Yourtree.tre" will be saved in folder of Step2 <br/>
# Step9: Showing your results in Mega software
Opening Mega software and enjoy!<br/>
<img src="https://user-images.githubusercontent.com/51614765/98496536-68848c80-2274-11eb-8447-0868e34752c7.png" width="15%"></img> <img src="https://user-images.githubusercontent.com/51614765/98496540-6a4e5000-2274-11eb-8625-032abe6ce0de.png" width="15%"></img> <br/>
# Done here and good luck!  
# Contact me if you make any trouble
gmail: sangcnsh.ntu@gmail.com <br/>
Mobile and Zalo: +84975359004<br/>



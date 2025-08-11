log() {
  local level="$1"
  shift
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  case "$level" in
    INFO)
      printf "[%s] [\033[32mINFO\033[0m] %s\n" "$timestamp" "$*"
      ;;
    WARNING)
      printf "[%s] [\033[33mWARNING\033[0m] %s\n" "$timestamp" "$*"
      ;;
    ERROR)
      printf "[%s] [\033[31mERROR\033[0m] %s\n" "$timestamp" "$*" >&2
      ;;
    DEBUG)
      printf "[%s] [\033[34mDEBUG\033[0m] %s\n" "$timestamp" "$*"
      ;;
    *)
      printf "[%s] [%s] %s\n" "$timestamp" "$level" "$*"
      ;;
  esac
}

remove_file() {
    local filename="$1"
    rm -f "${filename}"
    log INFO "delete file: ${filename}"
}

append_tool() {
    local source="$1"
    local target="$2"
    cat "$source" >> "$target"
    log INFO "append file: \"$source\" >> \"$target\""
}

regex_replace_file() {
    local filename="$1"
    local pattern="$2"
    local replacement="$3"
    python  srcs/regex_replace.py  "${filename}"  "${pattern}"  "${replacement}" 
    log INFO "regex replace: \"${filename}\" -- \"${pattern}\" -> \"${replacement}\""
}

remove_file my_script

append_tool ./scripts/define                 my_script    
append_tool ./scripts/ui                     my_script    
append_tool ./scripts/tool                   my_script    
append_tool ./scripts/loc_1_temple           my_script    
append_tool ./scripts/loc_2_icy_ridge        my_script    
append_tool ./scripts/loc_3_bronze_mine      my_script    
append_tool ./scripts/loc_4_undead_crypt     my_script    
append_tool ./scripts/loc_5_fungus_forest    my_script    
append_tool ./scripts/loc_6_caustic_caves    my_script    
append_tool ./scripts/loc_7_deadwood_valley  my_script    
append_tool ./scripts/loc_8_rocky_plateau    my_script    

regex_replace_file my_script  "^//.*\n"  "" 
regex_replace_file my_script  "^\s*//.*\n"  "" 
regex_replace_file my_script  "^\s*\n"  "" 
regex_replace_file my_script  "//.*"  "" 
regex_replace_file my_script  "/\*[\s\S]*?\*/\n"  "" 
regex_replace_file my_script  "\n^$"  "" 







# remove_file my_main

# append_tool ./scripts/define                 my_main   
# echo "import my_scripts/ui                   " >> my_main
# echo "import my_scripts/tool                 " >> my_main
# echo "import my_scripts/loc_1_temple         " >> my_main
# echo "import my_scripts/loc_2_icy_ridge      " >> my_main
# echo "import my_scripts/loc_3_bronze_mine    " >> my_main
# echo "import my_scripts/loc_4_undead_crypt   " >> my_main
# echo "import my_scripts/loc_5_fungus_forest  " >> my_main
# echo "import my_scripts/loc_6_caustic_caves  " >> my_main
# echo "import my_scripts/loc_7_deadwood_valley" >> my_main
# echo "import my_scripts/loc_8_rocky_plateau  " >> my_main

# mv ./scripts/ui                     ${ssrpg_scripts_path}/ui                  
# mv ./scripts/tool                   ${ssrpg_scripts_path}/tool                  
# mv ./scripts/loc_1_temple           ${ssrpg_scripts_path}/loc_1_temple          
# mv ./scripts/loc_2_icy_ridge        ${ssrpg_scripts_path}/loc_2_icy_ridge       
# mv ./scripts/loc_3_bronze_mine      ${ssrpg_scripts_path}/loc_3_bronze_mine     
# mv ./scripts/loc_4_undead_crypt     ${ssrpg_scripts_path}/loc_4_undead_crypt    
# mv ./scripts/loc_5_fungus_forest    ${ssrpg_scripts_path}/loc_5_fungus_forest   
# mv ./scripts/loc_6_caustic_caves    ${ssrpg_scripts_path}/loc_6_caustic_caves   
# mv ./scripts/loc_7_deadwood_valley  ${ssrpg_scripts_path}/loc_7_deadwood_valley 
# mv ./scripts/loc_8_rocky_plateau    ${ssrpg_scripts_path}/loc_8_rocky_plateau   
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
    python  regex_replace.py  "${filename}"  "${pattern}"  "${replacement}" 
    log INFO "regex replace: \"${filename}\" -- \"${pattern}\" -> \"${replacement}\""
}


remove_file my_script

append_tool ./scripts/tool                   my_script    
append_tool ./scripts/define                 my_script    
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
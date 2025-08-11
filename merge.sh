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
    log INFO "Delete file: ${filename}"
}

copy_file() {
    local src="$1"
    local dest_dir="$2"

    # 检查参数
    if [ -z "$src" ] || [ -z "$dest_dir" ]; then
        echo "Usage: copy_file <源文件> <目标目录>"
        return 1
    fi

    # 检查源文件是否存在
    if [ ! -f "$src" ]; then
        log ERROR "Source file does not exist or is not a regular file: $src"
        return 1
    fi

    # 检查目标路径是否存在
    if [ ! -e "$dest_dir" ]; then
        log ERROR "Destination path does not exist: $dest_dir"
        return 1
    fi

    # 检查目标路径是否为目录
    if [ ! -d "$dest_dir" ]; then
        log ERROR "Destination path is not a directory: $dest_dir"
        return 1
    fi

    # 复制文件
    cp "$src" "$dest_dir"
    log INFO "Copied: $src -> $dest_dir"
}

append_file() {
    local source="$1"
    local target="$2"
    cat "$source" >> "$target"
    log INFO "Append file: \"$source\" >> \"$target\""
}

append_str() {
    local source="$1"
    local target="$2"
    echo "$source" >> "$target"
    log INFO "Append string: \"$source\" >> \"$target\""
}

regex_replace_file() {
    local filename="$1"
    local pattern="$2"
    local replacement="$3"
    python  srcs/regex_replace.py  "${filename}"  "${pattern}"  "${replacement}" 
    log INFO "Regex replace: \"${filename}\" -- \"${pattern}\" -> \"${replacement}\""
}

remove_file my_script

append_file ./scripts/define                 my_script    
append_file ./scripts/ui                     my_script    
append_file ./scripts/tool                   my_script    
append_file ./scripts/loc_1_temple           my_script    
append_file ./scripts/loc_2_icy_ridge        my_script    
append_file ./scripts/loc_3_bronze_mine      my_script    
append_file ./scripts/loc_4_undead_crypt     my_script    
append_file ./scripts/loc_5_fungus_forest    my_script    
append_file ./scripts/loc_6_caustic_caves    my_script    
append_file ./scripts/loc_7_deadwood_valley  my_script    
append_file ./scripts/loc_8_rocky_plateau    my_script    

regex_replace_file my_script  "^//.*\n"  "" 
regex_replace_file my_script  "^\s*//.*\n"  "" 
regex_replace_file my_script  "^\s*\n"  "" 
regex_replace_file my_script  "//.*"  "" 
regex_replace_file my_script  "/\*[\s\S]*?\*/\n"  "" 
regex_replace_file my_script  "\n^$"  "" 




remove_file my_main

append_file ./scripts/define my_main   
append_str "import my_scripts/ui                   "  my_main
append_str "import my_scripts/tool                 "  my_main
append_str "import my_scripts/loc_1_temple         "  my_main
append_str "import my_scripts/loc_2_icy_ridge      "  my_main
append_str "import my_scripts/loc_3_bronze_mine    "  my_main
append_str "import my_scripts/loc_4_undead_crypt   "  my_main
append_str "import my_scripts/loc_5_fungus_forest  "  my_main
append_str "import my_scripts/loc_6_caustic_caves  "  my_main
append_str "import my_scripts/loc_7_deadwood_valley"  my_main
append_str "import my_scripts/loc_8_rocky_plateau  "  my_main

ssrpg_scripts_path="./test"
copy_file ./scripts/ui                     ${ssrpg_scripts_path}
copy_file ./scripts/tool                   ${ssrpg_scripts_path}
copy_file ./scripts/loc_1_temple           ${ssrpg_scripts_path}
copy_file ./scripts/loc_2_icy_ridge        ${ssrpg_scripts_path}
copy_file ./scripts/loc_3_bronze_mine      ${ssrpg_scripts_path}
copy_file ./scripts/loc_4_undead_crypt     ${ssrpg_scripts_path}
copy_file ./scripts/loc_5_fungus_forest    ${ssrpg_scripts_path}
copy_file ./scripts/loc_6_caustic_caves    ${ssrpg_scripts_path}
copy_file ./scripts/loc_7_deadwood_valley  ${ssrpg_scripts_path}
copy_file ./scripts/loc_8_rocky_plateau    ${ssrpg_scripts_path}
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

copy_and_rename_file() {
    local src_dir="$1"
    local src_file="$2"
    local src=${src_dir}/${src_file}
    local dest_dir="/c/Users/MonoColor/AppData/LocalLow/Martian Rex, Inc_/Stone Story/76561198192585611/Stonescript/Mys"

    # 检查参数
    if [ -z "$src" ] || [ -z "$dest_dir" ]; then
        echo "Usage: copy_and_rename_file <源文件目录> <源文件>"
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
    cp "${src}" "${dest_dir}"
    log INFO "Copied and rename: ${src} -> ${dest_dir}/${src_file}.txt"
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
append_file ./scripts/my_ui                  my_script    
append_file ./scripts/my_tool                my_script    
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
append_str "import Mys/MyScript"  my_main
# append_str "import Weapons/my_ui                 "  my_main
# append_str "import Weapons/my_tool               "  my_main
# append_str "import Weapons/loc_1_temple          "  my_main
# append_str "import Weapons/loc_2_icy_ridge       "  my_main
# append_str "import Weapons/loc_3_bronze_mine     "  my_main
# append_str "import Weapons/loc_4_undead_crypt    "  my_main
# append_str "import Weapons/loc_5_fungus_forest   "  my_main
# append_str "import Weapons/loc_6_caustic_caves   "  my_main
# append_str "import Weapons/loc_7_deadwood_valley "  my_main
# append_str "import Weapons/loc_8_rocky_plateau   "  my_main

remove_file MyScript.txt
append_file ./scripts/my_ui                  MyScript.txt
append_file ./scripts/my_tool                MyScript.txt
append_file ./scripts/loc_1_temple           MyScript.txt
append_file ./scripts/loc_2_icy_ridge        MyScript.txt
append_file ./scripts/loc_3_bronze_mine      MyScript.txt
append_file ./scripts/loc_4_undead_crypt     MyScript.txt
append_file ./scripts/loc_5_fungus_forest    MyScript.txt
append_file ./scripts/loc_6_caustic_caves    MyScript.txt
append_file ./scripts/loc_7_deadwood_valley  MyScript.txt
append_file ./scripts/loc_8_rocky_plateau    MyScript.txt

copy_and_rename_file . MyScript.txt               
# copy_and_rename_file ./scripts my_ui                   
# copy_and_rename_file ./scripts my_tool                 
# copy_and_rename_file ./scripts loc_1_temple         
# copy_and_rename_file ./scripts loc_2_icy_ridge      
# copy_and_rename_file ./scripts loc_3_bronze_mine    
# copy_and_rename_file ./scripts loc_4_undead_crypt   
# copy_and_rename_file ./scripts loc_5_fungus_forest  
# copy_and_rename_file ./scripts loc_6_caustic_caves  
# copy_and_rename_file ./scripts loc_7_deadwood_valley
# copy_and_rename_file ./scripts loc_8_rocky_plateau  
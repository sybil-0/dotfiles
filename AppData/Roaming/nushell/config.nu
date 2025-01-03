let carbonfox_theme = {
   binary: "#3ddbd9"
   block: "#b6b8bb"
   bool: "#5ae0df"
   cellpath: "#dfdfe0"
   date: "#25be6a"
   duration: "#25be6a"
   filesize: "#3ddbd9"
   float: "#3ddbd9"
   int: "#3ddbd9"
   list: "#b6b8bb"
   nothing: "#dfdfe0"
   range: "#dfdfe0"
   record: "#dfdfe0"
   string: "#25be6a"

   leading_trailing_space_bg: "#353535"
   header: "#b6b8bb"
   empty: "#78a9ff"
   row_index: "#7b7c7e"
   hints: "#7b7c7e"
   separator: "#6e6f70"

   shape_block: "#b6b8bb"
   shape_bool: "#5ae0df"
   shape_external: "#be95ff"
   shape_externalarg: "#dfdfe0"
   shape_filepath: "#dfdfe0"
   shape_flag: "#33b1ff"
   shape_float: "#3ddbd9"
   shape_globpattern: "#2dc7c4"
   shape_int: "#3ddbd9"
   shape_internalcall: "#be95ff"
   shape_list: "#b6b8bb"
   shape_literal: "#25be6a"
   shape_nothing: "#52bdff"
   shape_operator: "#b6b8bb"
   shape_record: "#b6b8bb"
   shape_string: "#25be6a"
   shape_string_interpolation: "#2dc7c4"
   shape_table: "#b6b8bb"
   shape_variable: "#dfdfe0"
}


$env.config = {
  show_banner: false,
  buffer_editor: "nvim",
  color_config: $carbonfox_theme
}

use ~/.cache/starship/init.nu
source ~/.zoxide.nu

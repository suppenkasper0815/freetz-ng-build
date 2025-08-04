[ "$FREETZ_AVM_VERSION_08_2X_MIN" == "y" ] || return 0
[ -L "${HTML_LANG_MOD_DIR}/home/home.lua" ] || return 0
echo1 "fixing home.lua symlink"

ln -s -f ../index.lua "${HTML_LANG_MOD_DIR}/home/home.lua"


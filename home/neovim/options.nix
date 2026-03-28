{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    autoindent = true;
    autoread = true;
    mouse = "";
    list = true;
    listchars = "tab:>─,eol:¬";

    colorcolumn = "80";
    cursorline = true;
    updatetime = 100;
  };
}

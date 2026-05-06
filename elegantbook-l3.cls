\def\elegant@date{2024/06/17}
\def\elegant@version{1.0}

\ExplSyntaxOn
\cs_new_protected_nopar:Npn \elegant_provide_module:n #1
  {
    \ProvidesExplFile{elegant-#1-module.code.tex}{\elegant@date}{\elegant@version}
    {ElegantLaTeX~ \text_titlecase:n { #1 } ~Module}
  }
\ExplSyntaxOff


\ProvidesExplClass{elegantbook-l3}{\elegant@date}{\elegant@version}{ElegantBook document class}

\cs_new_protected:Npn \elegant_msg_new:nn #1#2 
  { \msg_new:nnn { elegant } { #1 } { #2 } }

\cs_new_protected:Npn \elegant_msg_error:nn #1#2
  { \msg_error:nnn { elegant } { #1 } { #2 } }

\cs_new_protected:Npn \elegant_msg_warning:nnn #1#2#3
  { \msg_warning:nnnn { elegant } { #1 } { #2 } { #3 } }

\cs_generate_variant:Nn \elegant_msg_error:nn { nx }



\elegant_msg_new:nn { not found module }
  {
    The~Elegant~module~`#1'~not~found.
  }

\elegant_msg_new:nn { deprecated color option }
  {
    The~color~option~`#1'~is~deprecated.\\
    Please~use~`theme=#2'~instead.
  }

\elegant_msg_new:nn { unsupported color option }
  {
    The~color~option~`#1'~is~not~supported.\\
    Please~use~one~of~green,~cyan,~blue,~gray,~black,~or~none.
  }

\elegant_msg_new:nn { unsupported device option }
  {
    The~device~option~`#1'~is~not~supported.\\
    Please~use~`normal'~or~`pad'.
  }


\cs_new_protected_nopar:Npn \elegant_load_module:n #1 
  {
    \clist_map_inline:nn { #1 }
    {
      \file_if_exist_input:nF { elegant-##1-module.code.tex }
      {
        \elegant_msg_error:nn { not found module } { ##1 }
      }
    }
  }

\prop_gput:Nnn \g_msg_module_type_prop { elegant } { Class }
\prop_gput:Nnn \g_msg_module_name_prop { elegant } { ElegantBook }


\cs_new_protected_nopar:Npn \tl_if_exist_use:N #1
  {
    \tl_if_exist:NT #1 
    {
      \tl_use:N #1
    }
  }

\cs_generate_variant:Nn \tl_if_exist_use:N { c }


\prg_new_conditional:Npnn \elegant_if_package_loaded:n #1 {p, T, F, TF}
  {
    \@ifpackageloaded { #1 }
      \prg_return_true:
      \prg_return_false:
  }


% class options
\clist_new:N \g__elegant_base_class_options_clist

\cs_new_protected_nopar:Npn \__elegant_set_theme_from_legacy_color:nn #1#2
  {
    \tl_gset:Nn \g__elegant_theme_tl { #2 }
    \elegant_msg_warning:nnn { deprecated color option } { #1 } { #2 }
  }

\cs_new_protected_nopar:Npn \__elegant_set_theme_from_legacy_color:n #1
  {
    \str_case:nnF { #1 }
      {
        { green } { \__elegant_set_theme_from_legacy_color:nn { color=green } { Fresh~Green } }
        { cyan  } { \__elegant_set_theme_from_legacy_color:nn { color=cyan  } { Polar~Blue } }
        { blue  } { \__elegant_set_theme_from_legacy_color:nn { color=blue  } { Techno~Blue } }
        { gray  } { \__elegant_set_theme_from_legacy_color:nn { color=gray  } { Rocky~Gray } }
        { black } { \__elegant_set_theme_from_legacy_color:nn { color=black } { Neon~Black } }
        { none  } { \__elegant_set_theme_from_legacy_color:nn { color=none  } { Plain } }
      }
      { \elegant_msg_error:nn { unsupported color option } { #1 } }
  }

\cs_new_protected_nopar:Npn \__elegant_set_device:n #1
  {
    \str_case:nnF { #1 }
      {
        { normal } { \tl_gset:Nn \g__elegant_device_tl { normal } }
        { pad    } { \tl_gset:Nn \g__elegant_device_tl { pad } }
      }
      { \elegant_msg_error:nn { unsupported device option } { #1 } }
  }


% keys define 
\keys_define:nn { elegant / classoption }
  {
    lang .tl_set:N = \g__elegant_language_tl,
    lang .initial:n = cn,
    cn .code:n = \tl_gset:Nn \g__elegant_language_tl { cn },
    en .code:n = \tl_gset:Nn \g__elegant_language_tl { en },
    it .code:n = \tl_gset:Nn \g__elegant_language_tl { it },
    fr .code:n = \tl_gset:Nn \g__elegant_language_tl { fr },
    nl .code:n = \tl_gset:Nn \g__elegant_language_tl { nl },
    hu .code:n = \tl_gset:Nn \g__elegant_language_tl { hu },
    de .code:n = \tl_gset:Nn \g__elegant_language_tl { de },
    es .code:n = \tl_gset:Nn \g__elegant_language_tl { es },
    mn .code:n = \tl_gset:Nn \g__elegant_language_tl { mn },
    pt .code:n = \tl_gset:Nn \g__elegant_language_tl { pt },
    jp .code:n = \tl_gset:Nn \g__elegant_language_tl { jp },
    theme .tl_set:N = \g__elegant_theme_tl,
    theme .initial:n = {Techno~Blue},
    color .code:n = \__elegant_set_theme_from_legacy_color:n { #1 },
    green .code:n = \__elegant_set_theme_from_legacy_color:nn { green } { Fresh~Green },
    cyan .code:n = \__elegant_set_theme_from_legacy_color:nn { cyan } { Polar~Blue },
    blue .code:n = \__elegant_set_theme_from_legacy_color:nn { blue } { Techno~Blue },
    gray .code:n = \__elegant_set_theme_from_legacy_color:nn { gray } { Rocky~Gray },
    black .code:n = \__elegant_set_theme_from_legacy_color:nn { black } { Neon~Black },
    nocolor .code:n = \__elegant_set_theme_from_legacy_color:nn { nocolor } { Plain },
    device .code:n = \__elegant_set_device:n { #1 },
    device .initial:n = normal,
    normal .code:n = \tl_gset:Nn \g__elegant_device_tl { normal },
    pad .code:n = \tl_gset:Nn \g__elegant_device_tl { pad },
    font .tl_set:N = \g__elegant_font_tl,
    font .initial:n = { none },
    math .tl_set:N = \g__elegant_math_tl,
    math .initial:n = { cm },
    cm .code:n = \tl_gset:Nn \g__elegant_math_tl { cm },
    newtx .code:n = \tl_gset:Nn \g__elegant_math_tl { newtx },
    mtpro2 .code:n = \tl_gset:Nn \g__elegant_math_tl { mtpro2 },
    stixtwo .code:n = \tl_gset:Nn \g__elegant_math_tl { stixtwo },
    xits .code:n = \tl_gset:Nn \g__elegant_math_tl { xits },
    tg .code:n = \tl_gset:Nn \g__elegant_math_tl { tg },
    tocdepth .int_set:N = \g__elegant_tocdepth_int,
    tocdepth .initial:n = 1,
    secnumdepth .int_set:N = \g__elegant_secnumdepth_int,
    secnumdepth .initial:n = 5,
    usesamecnt .bool_set:N = \g__elegant_usesamecnt_bool,
    usesamecnt .initial:n = false,
    usesamecnt .default:n = true,
    thmcnt .tl_set:N = \g__elegant_thmcnt_tl,
    thmcnt .initial:n = { chapter },
    toc .tl_set:N = \g__elegant_toc_tl,
    toc .initial:n = { onecol },
    onecol .code:n = \tl_gset:Nn \g__elegant_toc_tl { onecol },
    twocol .code:n = \tl_gset:Nn \g__elegant_toc_tl { twocol },
    titlestyle .tl_set:N = \g__elegant_title_style_tl,
    titlestyle .initial:n = { hang },
    hang .code:n = \tl_gset:Nn \g__elegant_title_style_tl { hang },
    display .code:n = \tl_gset:Nn \g__elegant_title_style_tl { display },
    citestyle .tl_set:N = \g__elegant_citestyle_tl,
    citestyle .initial:n = { numeric-comp },
    bibstyle .tl_set:N = \g__elegant_bibstyle_tl,
    bibstyle .initial:n = { numeric },
    bibend .tl_set:N = \g__elegant_bibend_tl,
    bibend .initial:n = { biber },
    biber .code:n = \tl_gset:Nn \g__elegant_bibend_tl { biber },
    bibtex .code:n = \tl_gset:Nn \g__elegant_bibend_tl { bibtex },
    gb7714 .code:n =
      {
        \tl_gset:Nn \g__elegant_citestyle_tl { gb7714-2015 }
        \tl_gset:Nn \g__elegant_bibstyle_tl { gb7714-2015 }
      },
    gbt7714 .code:n =
      {
        \tl_gset:Nn \g__elegant_citestyle_tl { gb7714-2015 }
        \tl_gset:Nn \g__elegant_bibstyle_tl { gb7714-2015 }
      },
    gb7714-2015 .code:n =
      {
        \tl_gset:Nn \g__elegant_citestyle_tl { gb7714-2015 }
        \tl_gset:Nn \g__elegant_bibstyle_tl { gb7714-2015 }
      },
    unknown.code:n = \__elegant_parse_unknown_option:n { #1 }
  }


\cs_new_protected_nopar:Npn \__elegant_parse_unknown_option:n #1
{
  \tl_if_empty:nTF { #1 }
  {
    \clist_gput_right:NV \g__elegant_base_class_options_clist \l_keys_key_str
  }
  {
    \exp_args:NNx \clist_gput_right:Nn \g__elegant_base_class_options_clist { \l_keys_key_str = \exp_not:n {#1} }
  }
}


\cs_if_exist:NTF \ProcessKeyOptions 
  {
    \ProcessKeyOptions[ elegant / classoption ]
  }
  {
    \RequirePackage{l3keys2e}
    \ProcessKeysOptions{ elegant / classoption }
  }

\AddToHook{ class / after }
  {
    \int_gset_eq:NN \c@tocdepth    \g__elegant_tocdepth_int 
    \int_gset_eq:NN \c@secnumdepth \g__elegant_secnumdepth_int 
  }

\PassOptionsToClass{ oneside } { book }  

\exp_args:NNV \LoadClass[\g__elegant_base_class_options_clist]{book}





% #1: module, #2: name, #3: position, #4: code
\cs_new_protected:Npn \elegant_add_to_hook:nnnn #1#2#3#4
  {
    \hook_gput_code:nnn { elegant-module / #1 / #2 / #3 }{.}{#4}
  }

% I don't know why... But I want to remove xeCJK dependency in elegantbook...
% \hook_gput_code:nnn{begindocument/before}{.}
%   {
%     \let \xeCJK@document@left@hook \relax
%     \let \xeCJK@document@hook \relax
%   }

\elegant_load_module:n { font }

\elegant_load_module:n { option }

\elegant_load_module:n { language }

\elegant_load_module:n { theme }

\elegant_load_module:n { cover }



\elegant_load_module:n { math }

\elegant_load_module:n { core }

\elegant_load_module:n { theorem }

\elegant_load_module:n { bibliography }

\elegant_load_module:n { toc }

\elegant_load_module:n { code }




\endinput

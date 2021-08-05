//==================================================================
/// [:VIM_EVAL:]expand('%:t')[:END_EVAL:]
///
/// Created by Davide Pasca - [:VIM_EVAL:]strftime('%Y/%m/%d')[:END_EVAL:]
/// See the file "license.txt" that comes with this project for
/// copyright info.
//==================================================================

#ifndef [:VIM_EVAL:]toupper(substitute(expand('%:t'), "\\.", "_", ""))[:END_EVAL:]
#define [:VIM_EVAL:]toupper(substitute(expand('%:t'), "\\.", "_", ""))[:END_EVAL:]

//==================================================================
class [:VIM_EVAL:]expand('%:t:r')[:END_EVAL:]
{
public:
    [:VIM_EVAL:]expand('%:t:r')[:END_EVAL:]();
};

#endif

#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Fri Aug 14 15:12:03 EDT 2020
##### Purpose: zsh script to hold expand lib fns
##### Notes: 
# Usage for external service like fzf.  Must have BUFFER, LBUFFER, RBUFFER set like ZLE does.
#
# zpwrExpandParseWords
# zpwrExpandIsLastWordLastCommand
#
# if $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] == true; then
#   echo $ZPWR_VARS[ORIGINAL_LAST_COMMAND]
# fi
#
#
#}}}***********************************************************

function zpwrExpandParseWords(){

    local i lastword_partition firstIndex lastIndex finalWord
    local -a mywordsleft mywordsright mywordsall lbufAry lpartAry lastWordAry partitionAry

    # loop through words to get first and last words in partition
    mywordsleft=(${(Az)${(z)LBUFFER:gs/<(/(}})
    loggDebug "my words left = $mywordsleft"

    # we must find the first index of the partition
    firstIndex=0
    # we must find the last index of the partition
    lastIndex=0

    for (( i = $#mywordsleft; i >= 0; i-- )); do
        # ;; ; | || && are partition separating chars
        # we will split the commad line and get the partition of the caret
        # aliases are valid in the first position after these chars
        case $mywordsleft[$i] in
            ';;' | \; | \| | '||' | '&&' | '<(' | '(' | '{')
                firstIndex=$((i+1))
                break
                ;;
            *)
                ;;
        esac
    done

    loggDebug "first index = $firstIndex"

    (( lastIndex += $#mywordsleft ))


    ZPWR_EXPAND_WORDS_LPARTITION=($mywordsleft[$firstIndex,$#mywordsleft])
    ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]=ZPWR_EXPAND_WORDS_LPARTITION

    loggDebug "lpartition = '${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}'"

    lpartAry=(${(z)${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}})

    ZPWR_VARS[firstword_partition]=${lpartAry[1]}

    ZPWR_VARS[lastword_lbuffer]=${lpartAry[-1]}

    # to get rid of double quotes
    loggDebug "first word partition = ...$ZPWR_VARS[firstword_partition]..."
    loggDebug "last word lbuf before no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    lbufAry=(${(z)${ZPWR_VARS[lastword_lbuffer]//\"/}})

    ZPWR_VARS[lastword_lbuffer]=${lbufAry[-1]}
    loggDebug "last word lbuf after no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    loggDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    loggDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."

    lastWordAry=(${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)\']/}})
    finalWord=${lastWordAry[-1]}
    ZPWR_VARS[lastword_remove_special]=$finalWord

    loggDebug "last word no special chars...${ZPWR_VARS[lastword_remove_special]}..."
}

function zpwrExpandIsLastWordLastCommand(){

    local moveCursor=$1
    local expand=$2
    local commandWords

    if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} == 1 )); then
        # regular alias expansion
        # remove space from menuselect spacebar
        if [[ ${LBUFFER: -1} == " " ]]; then
            LBUFFER="${LBUFFER:0:-1}"
        fi
        if [[ $expand == expand ]]; then
            zpwrExpandCommonParameterExpansion
            words=(${(z)ZPWR_VARS[EXPANDED]})
            if [[ ${words[1]} == "$ZPWR_VARS[lastword_lbuffer]" ]];then
                # escape the expanded form because its first word is an alias itself
                zpwrExpandAliasEscape
                zpwrExpandGoToTabStopOrEndOfLBuffer
            else
                zpwrExpandAlias
            fi
            if [[ $moveCursor == moveCursor ]]; then
                zpwrExpandGoToTabStopOrEndOfLBuffer
            fi
        fi
        ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]

    elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} >= 2 )); then
        # regular alias expansion after sudo
        if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then


            if [[ "${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}" =~ "$ZPWR_VARS[continueFirstPositionRegex]" ]];then
                commandWords=("${(z)match[-1]}")
                loggDebug "${match[@]}"
                loggDebug "${commandWords[@]}"

                if (( $#commandWords == 1)); then
                    if [[ $expand == expand ]]; then
                        zpwrExpandCommonParameterExpansion
                        zpwrExpandAlias
                        if [[ $moveCursor == moveCursor ]]; then
                            zpwrExpandGoToTabStopOrEndOfLBuffer
                        fi
                    fi
                    ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                else
                    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                fi
            else
                ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                loggDebug "no match ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION] '$ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]'"
            fi
        fi

    fi
}

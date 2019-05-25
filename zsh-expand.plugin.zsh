subForAtSign=:::::---::::---:::::---
expandGlobalAliases() {
    lastword_lbuffer="$1"
    #expand alias
    res=${(Q)${(qqq)galiases[$lastword_lbuffer]:gs@\\@\\\\@}:gs@$@\\$@}
    res=${res//@/$subForAtSign}
    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
    LBUFFER=${LBUFFER//$subForAtSign/@}
    LBUFFER=${LBUFFER:gs|\\\\|\\|}
    lenToFirstTS=${#BUFFER%%$__TS*}
    if (( $lenToFirstTS < ${#BUFFER} )); then
        CURSOR=$lenToFirstTS
        RBUFFER=${RBUFFER:$#__TS}
        __EXPAND=false
    else
        __EXPAND=true
    fi
}

supernatural-space() {
set +x
    local __CORRECT_WORDS
    declare -A __CORRECT_WORDS
    __CORRECT_WORDS[about]="aobut"
    __CORRECT_WORDS[alternate]="alternaet alterntae"
    __CORRECT_WORDS[also]="laso alos"
    __CORRECT_WORDS[and]="adn nad"
    __CORRECT_WORDS[are]="aer rea"
    __CORRECT_WORDS[array]="ary arr"
    __CORRECT_WORDS[automatically]="auto"
    __CORRECT_WORDS[back]="bkac bakc abck"
    __CORRECT_WORDS[bad]="bda abd"
    __CORRECT_WORDS[based]="baesd absed"
    __CORRECT_WORDS[best]="bets"
    __CORRECT_WORDS[between]="bt between"
    __CORRECT_WORDS[by_the_way]="btw"
    __CORRECT_WORDS[block]="blokc bolck lbock"
    __CORRECT_WORDS[capture]="catpure catprue caputre"
    __CORRECT_WORDS[change]="cahnge chnage changen"
    __CORRECT_WORDS[client]="cleint"
    __CORRECT_WORDS[click]="clikc"
    __CORRECT_WORDS[create]="craete"
    __CORRECT_WORDS[custom]="custmo cusotm"
    __CORRECT_WORDS[declare]="delcare declaer"
    __CORRECT_WORDS[default]="defalut deafult"
    __CORRECT_WORDS[dependencies]="deps dependenceis"
    __CORRECT_WORDS[dependency]="dep dependenc"
    __CORRECT_WORDS[directory]="dir idr direcotry direcorty directroy"
    __CORRECT_WORDS[docker]="dokcer"
    __CORRECT_WORDS[double]="dbl"
    __CORRECT_WORDS[drag]="darg"
    __CORRECT_WORDS[echo]="ehco eho ceho ecoh eco"
    __CORRECT_WORDS[exit]="eixt"
    __CORRECT_WORDS[expansion]="exp"
    __CORRECT_WORDS[file]="feil fiel"
    __CORRECT_WORDS[finger]="fingre finegr figner"
    __CORRECT_WORDS[for]="forr forrr fro rfo rof fr ofr"
    __CORRECT_WORDS[found]="ofund fuond foudn"
    __CORRECT_WORDS[function]="fxn func fn"
    __CORRECT_WORDS[go]="og"
    __CORRECT_WORDS[here]="ehre"
    __CORRECT_WORDS[high]="hgih hihg ihgh hi"
    __CORRECT_WORDS[images]="iamges"
    __CORRECT_WORDS[is]="si ise"
    __CORRECT_WORDS[inside]="insdie isndie inisde isnide sindie"
    __CORRECT_WORDS[instead]="insaed instaed"
    __CORRECT_WORDS[just]="jsut jutsi just"
    __CORRECT_WORDS[like]="liek"
    __CORRECT_WORDS[location]="locaiton lcoation"
    __CORRECT_WORDS[lock]="lokc lcok"
    __CORRECT_WORDS[more]="moer"
    __CORRECT_WORDS[mount]="mounr mounf"
    __CORRECT_WORDS[namespace]="namepsace naemspace naempsace"
    __CORRECT_WORDS[night]="nite"
    __CORRECT_WORDS[number]="numbre numebr nr"
    __CORRECT_WORDS[not]="nto tno"
    __CORRECT_WORDS[of]="fo"
    __CORRECT_WORDS[or]="ro"
    __CORRECT_WORDS[outside]="otuside outsdie"
    __CORRECT_WORDS[over]="voer ovre"
    __CORRECT_WORDS[other]="othe toher"
    __CORRECT_WORDS[name]="anme naem"
    __CORRECT_WORDS[network]="newtork entwork ntework"
    __CORRECT_WORDS[parameter]="parm"
    __CORRECT_WORDS[parameters]="parms"
    __CORRECT_WORDS[perl]="prel"
    __CORRECT_WORDS[please]="plase plz"
    __CORRECT_WORDS[point]="opint ponit"
    __CORRECT_WORDS[print]="pirnt pritn rpint prnit"
    __CORRECT_WORDS[probe]="porbe rpobe"
    __CORRECT_WORDS[project]="projcet proejct proeject porject"
    __CORRECT_WORDS[radius]="radisu raduis"
    __CORRECT_WORDS[range]="rnage arnge"
    __CORRECT_WORDS[runnning]="runnign"
    __CORRECT_WORDS[shell_script]="shel"
    __CORRECT_WORDS[single]="signle"
    __CORRECT_WORDS[some]="soem som seom"
    __CORRECT_WORDS[sound]="osund"
    __CORRECT_WORDS[spelling]="spellign spelilng"
    __CORRECT_WORDS[state]="staet steta sttae"
    __CORRECT_WORDS[store]="tsore sotre"
    __CORRECT_WORDS[string]="stirng stinrg"
    __CORRECT_WORDS[than]="tahn"
    __CORRECT_WORDS[that]="taht"
    __CORRECT_WORDS[the]="teh hte eht eth te th"
    __CORRECT_WORDS[their]="thier"
    __CORRECT_WORDS[they]="tehy ethy"
    __CORRECT_WORDS[this]="tihs htis"
    __CORRECT_WORDS[then]="tehn"
    __CORRECT_WORDS[true]="treu ture"
    __CORRECT_WORDS[to]="ot"
    __CORRECT_WORDS[tomorrow]="tmr"
    __CORRECT_WORDS[transfer]="xfer"
    __CORRECT_WORDS[under]="uner udner uder"
    __CORRECT_WORDS[using]="suing usnig"
    __CORRECT_WORDS[usually]="usu"
    __CORRECT_WORDS[value]="vlaue valeu"
    __CORRECT_WORDS[with]="with wiht itwh iwth"
    __CORRECT_WORDS[why]="hwy wyh"
    __CORRECT_WORDS[without]="wo"
    __CORRECT_WORDS[work]="wrk werk owrk wokr"

    local TEMP_BUFFER mywords badWords
    TEMP_BUFFER="$(print -r -- $LBUFFER | tr -d "()[]{}\$,%'\"" )"
    mywords=("${(z)TEMP_BUFFER}")
    finished=false

    for key in ${(k)__CORRECT_WORDS[@]}; do
        badWords=("${(z)__CORRECT_WORDS[$key]}")
        for misspelling in $badWords[@];do
            if [[ $mywords[-1] == $misspelling ]]; then
                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE \
                    "s@\\b$misspelling\\b\$@${key:gs/_/ /}@g")"
                finished=true
                CURSOR=$#LBUFFER
                break
            fi
        done
        [[ $finished == true ]] && break
    done

    __EXPAND=true

    #loop through words to get first and last words in partition
    mywordsleft=(${(z)LBUFFER})
    mywordsright=(${(z)RBUFFER})
    mywordsall=(${(z)BUFFER})
    firstIndex=0
    lastIndex=0
    for (( i = $#mywordsleft; i >= 0; i-- )); do
        case $mywordsleft[$i] in
            \; | \| | '||' | '&&')
                firstIndex=$((i+1))
                break
                ;;
            *)
                ;;
        esac
    done
    for (( i = 0; i < $#mywordsright; i++ )); do
        case $mywordsright[$i] in
            \; | \| | '||' | '&&') lastIndex=$((i-1))
                break
                ;;
            *)
                ;;
        esac
    done

    ((lastIndex+=$#mywordsleft))
    mywords_lbuffer=($mywordsleft[$firstIndex,$#mywordsleft])
    mywords_partition=($mywordsall[$firstIndex,$lastIndex])
    #logg "partition = '$mywords_lbuffer'"
    firstword_partition=${mywords_lbuffer[1]}
    lastword_lbuffer=${mywords_lbuffer[-1]}
    lastword_lbuffer=${${(z)${mywords_lbuffer//\"/}}[-1]}
    lastword_partition=${mywords_partition[-1]}
    #logg "first word = '$firstword_partition'"
    #logg "last word = '$lastword_lbuffer'"
    __ALIAS=false
    

    #dont expand =word because that is zle expand-word
    if [[ ${lastword_lbuffer:0:1} != '=' ]] && (( $#lastword_lbuffer > 0 ));then
        if alias -r -- $lastword_lbuffer | \
            command egrep -qv '(grc|_z|cd|hub)';then
            #logg "regular=>'$lastword_lbuffer'"
            if (( $#mywords_lbuffer == 2 )); then
                #regular alias expansion after sudo
                if [[ $EXPAND_SECOND_POSITION == true ]]; then
                    if echo "$firstword_partition" | grep -qE '(sudo)';then
                        res="$(alias -r $lastword_lbuffer | cut -d= -f2-)"
                        #deal with ansi quotes $'
                        [[ $res[1] == \$ ]] && res=${res:1}
                        res=${(Q)res}
                        res=${res:gs@\\@\\\\@}
                        res=${res:gs@\\\\n@\\n@}
                        res=${res:gs@\$@\\\$@}
                        res=${res:gs|@|$(echo $subForAtSign)}
LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
                        LBUFFER=${LBUFFER:gs|$subForAtSign|@|}
                        lenToFirstTS=${#BUFFER%%$__TS*}
                        if (( $lenToFirstTS < ${#BUFFER} )); then
                            CURSOR=$lenToFirstTS
                            RBUFFER=${RBUFFER:$#__TS}
                            __EXPAND=false
                        else
                            __EXPAND=true
                        fi
                    fi
                fi
            elif (( $#mywords_lbuffer == 1 )); then
                #regular alias expansion
                #remove space from menuselect spacebar
                if [[ ${LBUFFER: -1} == " " ]]; then
                    LBUFFER="${LBUFFER:0:-1}"
                fi
                res="$(alias -r $lastword_lbuffer | cut -d= -f2-)"
                #deal with ansi quotes $'
                [[ $res[1] == \$ ]] && res=${res:1}
                res=${(Q)res}
                res=${res:gs@\\@\\\\@}
                res=${res:gs@\\\\n@\\n@}
                res=${res:gs@\$@\\\$@}
                res=${res:gs|@|$(echo $subForAtSign)}
                words=(${(z)res})
                if [[ ${words[1]} == "$lastword_lbuffer" ]];then
LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@\\\\$res@")"
                else
LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
                fi
                LBUFFER=${LBUFFER//$subForAtSign/@}
                lenToFirstTS=${#BUFFER%%$__TS*}
                if (( $lenToFirstTS < ${#BUFFER} )); then
                    CURSOR=$lenToFirstTS
                    RBUFFER=${RBUFFER:$#__TS}
                    __EXPAND=false
                else
                    __EXPAND=true
                fi
            fi
            __ALIAS=true
        else
            #remove space from menuselect spacebar
            if [[ ${LBUFFER: -1} == " " ]]; then
                LBUFFER="${LBUFFER:0:-1}"
            fi
            if echo "$lastword_lbuffer" | \fgrep -q '"'; then
                #expand on last word of "string" for global aliases only
                lastword_lbuffer=${lastword_lbuffer:gs/\"//}
                ary=(${(z)lastword_lbuffer})
                lastword_lbuffer=$ary[-1]
            fi
            if alias -g -- $lastword_lbuffer | grep -q "." &>/dev/null;then
                #global alias expansion
                #logg "global=>'$lastword_lbuffer'"
                expandGlobalAliases "$lastword_lbuffer"
                __ALIAS=true
            fi
        fi

        if [[ ! -f "$lastword_lbuffer" ]]; then
            :
            #DNS lookups
            #type -a "$lastWord" &> /dev/null || {
                #print -r -- $lastWord | grep -qE \
                #'^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\.?$'\
                #&& {
                    ##DNS lookup
                    #A_Record=$(host $lastWord) 2>/dev/null \
                        #&& {
                        #A_Record=$(print -r -- $A_Record | grep ' address' | head -1 | awk '{print $4}')
                    #} || A_Record=bad
                    #[[ $A_Record != bad ]] && \
                        #LBUFFER="$(print -r -- "$LBUFFER" | sed -E "s@\\b$lastWord@$A_Record@g")"
                #} || {
                    #print -r -- $lastWord | grep -qE \
                    #'\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' && {
                    ##reverse DNS lookup
                    #PTR_Record=$(nslookup $lastWord) 2>/dev/null && {
                        #PTR_Record=$(print -r -- $PTR_Record | grep 'name = ' | tail -1 | awk '{print $4}')
                    #} || PTR_Record=bad
                        #[[ $PTR_Record != bad ]] && \
                            #LBUFFER="$(print -r -- "$LBUFFER" | sed -E "s@\\b$lastWord\\b@${PTR_Record:0:-1}@g")"
                    #}
                #}
            #}
        else
            #its a file
        fi
    fi
    if [[ $__ALIAS != true ]]; then
        #expand globs, parameters and =
        zle expand-word
    fi

    if [[ $__EXPAND == true ]];then
        #insert the space char
        zle self-insert
    else
        #invoke syntax highlighting
        zle self-insert
        zle backward-delete-char
    fi
    set +x
}

terminate-space(){
    LBUFFER+=" "
}

zle -N supernatural-space
zle -N terminate-space

bindkey -M viins " " supernatural-space
bindkey -M viins "^@" terminate-space

zle -N expandGlobalAliases

bindkey '\e^E' expandGlobalAliases

"{{{1 Начало
scriptencoding utf-8
if (exists("s:g._pluginloaded") && s:g._pluginloaded) ||
            \exists("g:chkOptions.DoNotLoad")
    finish
"{{{1 Первая загрузка
elseif !exists("s:g._pluginloaded")
    "{{{2 Объявление переменных
    execute load#Setup('0.6')
    call map(["stuf", "cchk", "achk", "tran", "comm", "mod"],
                \'extend(s:F, {v:val : {}})')
    lockvar 1 s:F
    "{{{2 Словарные функции
    let s:g._load.dictfunctions=[
                \["checkargument",  "achk._main_init", {}],
                \["checkarguments", "cchk._main_init", {}]]
    "{{{2 Регистрация дополнения
    let s:g._load.requires=[["load", '0.6']]
    let s:g._load.reginfo=s:F.plug.load.registerplugin(s:g._load)
    let s:F.main._eerror=s:g._load.reginfo.functions.eerror
    "}}}2
    finish
endif
"{{{1 Вторая загрузка
let s:g._pluginloaded=1
unlet s:g._load
"{{{2 Выводимые сообщения
let s:g.p={
            \"emsg": {
            \   "ttran": "Invalid transformation type: ArgTrans must be either".
            \            "List or Dictionary",
            \   "ltran": "Value for %s transformation must be a List",
            \   "ftran": "Value for %s transformation must be either ".
            \            'a callable function reference or '.
            \            'a name of some callable function',
            \   "stran": "Value for %s transformation must be a String",
            \    "lchk": "Invalid check type: Check must be a List",
            \     "num": "Value must be number",
            \    "bool": "Value must be number, equal to either 0 or 1",
            \    "uint": "Value must be unsigned integer",
            \     "int": "Value must be integer",
            \    "func": "Value must be a reference to a function",
            \   "funcs": "Value must be either a reference to a function ".
            \            "or a string",
            \     "str": "Value must be of a type “string”",
            \    "dict": "Value must be of a type “dictionary”",
            \    "list": "Value must be of a type “list”",
            \    "nums": "Value must be a string representation of either ".
            \            "Number or Float",
            \   "kbool": "Key “allowtrun” must be number, equal to either ".
            \            '0 or 1',
            \    "type": "Invalid type",
            \   "notin": "Value not in list %s",
            \    "nreg": "Value does not match regular expression /%s/",
            \   "nfunc": "Function %s returned a error",
            \   "mmiss": "Key “model” is missing",
            \    "uknm": "Unknown model",
            \    "uchk": "Uknown check",
            \     "upr": "Found uknown prefix %s in position %u",
            \     "uvt": "Uknown variable type",
            \    "uact": "Unknown action “%s” in position %u",
            \    "ukey": "Invalid key: key “%s” does not match any check",
            \    "ufct": "Uknown file check type",
            \    "aexp": "Expected action in position %u, but got nothing",
            \    "estr": "Expected string in position %u",
            \      "uf": "Number must be greater then or equal to %g",
            \      "of": "Number must be less then or equal to %g",
            \     "key": "Key “%s” not found",
            \    "nkey": "Dictionary does not have “%s” key",
            \    "vars": "Variable name must start either with a latin letter ".
            \            "and a colon or with an ampersand",
            \   "varls": "Cannot accept function (l: and a:) and ".
            \            "script (s:) variable names",
            \   "varne": "Variable does not exist",
            \     "neq": "Value not equal to “%s”",
            \    "ivar": "Invalid variable name",
            \    "ichk": "Invalid check",
            \    "ival": "Invalid value",
            \   "kival": "Invalid value for key “%s”",
            \   "eival": "Invalid value in position %u",
            \   "elval": "Invalid list item with index %u",
            \   "lival": "Invalid list of arguments starting from %u",
            \    "ilen": "Invalid length: expected %u, but got %u",
            \    "<len": "Invalid length: expected at least %u, but got %u",
            \    ">len": "Invalid length: expected at most %u, but got %u",
            \    "rlen": "length of argument list must match number of ".
            \            "required arguments",
            \    "mlen": "length of argument list must not be greater then ".
            \            "maximum number of arguments (required+optional)",
            \     "ina": "Invalid number of arguments: %u (unexpected end of ".
            \            "list of prefixed values)",
            \    "irng": "Invalid range: %u is greater then %u",
            \    "ireg": "Invalid regular expression “%s”",
            \    "cstr": "First element in Check is its name, so it must be ".
            \            "of a type “string”",
            \    "topt": "Too many optional arguments",
            \   "tslst": "Too short list: expected at least %u, but got %u",
            \   "tllst": "Too long list: expected at most %u, but got %u",
            \   "eexpr": "Expression resulted in error: %s",
            \   "efunc": "Running function failed with error “%s”",
            \   "evalf": "Eval failed",
            \    "chkf": "Check #%u failed",
            \    "chks": "Check #%u succeed, but some previous check failed",
            \     "amb": "Ambigious argument “%s”: cannot expand it to full ".
            \            "version",
            \    "pmis": "Some required keys are missing: “%s”",
            \   "nfull": "Full version of argument “%s” not found",
            \      "pl": "Prefix list must be a list of strings",
            \     "hid": "Invalid highlight group identifier: ".
            \            "it must contain only letters, digits and underscores",
            \     "hnf": "Highlight group not found",
            \   "cfunc": "Reference to function %s is not callable",
            \    "fnex": "Function with name %s does not exist",
            \   "dupor": "The following prefixes are present both ".
            \            "in prefrequired and prefoptional: %s",
            \    "udpr": "Unknown or duplicate prefix in position %u: %s",
            \   "nropr": "List prefix is neither required nor optional: %s",
            \    "nmod": "Model not specified",
            \   "cdict": "Check must have Dictionary type",
            \   "modns": "Check model must have String type",
            \    "nact": "Actions dictionary is missing",
            \   "tnlst": "Transformation description must have List type",
            \     "tn2": "Transformation description must be two items long",
            \   "tnstr": "First item of transformation description must have ".
            \            "String type",
            \   "utran": "Unknown transformation: %s",
            \     "ifn": "String “%s” is not a valid function name",
            \   "andct": "Key “actions” must contain a dictionary",
            \   "pnstr": "Invalid item %u in “preflist”: ".
            \            "it must have String type",
            \   "upref": "Invalid item “%s” in postion %u in “preflist”: ".
            \            "it must be present either in “prefrequired” ".
            \            "or “prefoptional” dictionaries as well",
            \    "nreq": "Key “required” is missing",
            \   "eoval": "Invalid optional value for prefix “%s”",
            \},
            \"etype": {
            \     "value": "InvalidValue",
            \       "chk": "InvalidCheck",
            \       "mod": "InvalidModel",
            \     "trans": "InvalidTransformation",
            \},
            \"lq": "“",
            \"rq": "”",
        \}
"{{{1 Вторая загрузка — функции
"{{{2 stuf: checkwr, regescape, string
"{{{3 stuf.checkwr: проверить возможность записи в файл
function s:F.stuf.checkwr(fname)
    let fwr=filewritable(a:fname)
    return (fwr==1 || (fwr!=2 && !filereadable(a:fname) &&
                \filewritable(fnamemodify(a:fname, ":p:h"))==2))
endfunction
"{{{3 stuf.regescape
function s:F.stuf.regescape(str)
    return escape(a:str, '^$*~[]\')
endfunction
"{{{3 stuf.string
function s:F.stuf.string(obj)
    try
        let r=string(a:obj)
    catch
        redir => r
        silent echo a:obj
        redir END
        let r=r[1:]
    endtry
    return r
endfunction
"{{{2 main: eerror, destruct
"{{{3 main.destruct: выгрузить плагин
function s:F.main.destruct()
    unlet s:g
    unlet s:F
    return 1
endfunction
"{{{3 main.eerror
let s:F.main.doredir=0
function s:F.main.eerror(...)
    if self.doredir
        call add(self.errors, [self.doredir, a:000])
    else
        call call(s:F.main._eerror, a:000, {})
    endif
    return 0
endfunction
"{{{3 main.echoerrors
function s:F.main.echoerrors(...)
    let errors=[]
    while !empty(self.errors) && self.errors[-1][0]>self.doredir
        call add(errors, remove(self.errors, -1)[1])
    endwhile
    if empty(a:000) && self.doredir
        return
    endif
    while !empty(errors)
        call call(s:F.main._eerror, remove(errors, -1), {})
    endwhile
endfunction
"{{{2 comm: getarg
"{{{3 s:g.comm
let s:g.comm={ "rdict": {} }
"{{{3 comm.getarg: Получить аргумент
function s:F.comm.getarg(chk, arg)
    let selfname="comm.getarg"
    if type(a:chk)!=type({})
        if type(a:chk)==type([])
            let chk={"check": a:chk}
        else
            return s:F.main.eerror(selfname, "chk", ["ttran"])
        endif
    else
        let chk=a:chk
    endif
    if has_key(chk, "check") && !s:F.achk._main_init(chk.check, a:arg)
        return 0
    endif
    if has_key(chk, "trans")
        let tres=s:F.tran._main(chk.trans, a:arg)
        if type(tres)!=type({})
            return 0
        endif
        if has_key(chk, "transchk") && !s:F.achk._main_init(chk.transchk,
                    \                                       tres.result)
            return 0
        endif
        return tres
    endif
    if has_key(chk, "skip")
        return {}
    endif
    return {"result": a:arg}
endfunction
"{{{2 tran: _main
"{{{3 s:g.tran
let s:g.tran={}
"{{{4 Проверки для аргументов
let s:g.tran.transchecks={
            \"pipe": ["type(l:Trans)==".type([]),
            \                                 printf(s:g.p.emsg.ltran, "pipe")],
            \"call": ["type(l:Trans)==".type([]),
            \                                 printf(s:g.p.emsg.ltran, "call")],
            \"func": ["s:F.achk.isfunc(1, l:Trans)",
            \                                 printf(s:g.p.emsg.ftran, "func")],
            \"eval": ["type(l:Trans)==".type(''),
            \                                 printf(s:g.p.emsg.stran, "eval")],
            \"earg": ["1",                      ""                            ],
            \  "eq": ["1",                      ""                            ],
        \}
"{{{4 Простые трансформации
let s:g.tran.simpletrans={
            \"func": "call(a:Trans, [a:Arg], {})",
            \"eval": "eval(a:Trans)",
            \"earg": "eval(a:Arg)",
            \"call": "call(a:Arg, a:Trans, {})",
            \  "eq": "type(a:Arg)==type(a:Trans) && a:Arg==#a:Trans",
        \}
for s:T in keys(s:g.tran.simpletrans)
    execute      "function s:F.tran.".s:T."(Trans, Arg)\n".
                \"    return {'result': ".s:g.tran.simpletrans[s:T]."}\n".
                \"endfunction"
endfor
unlet s:T
"{{{3 tran.pipe
function s:F.tran.pipe(Trans, Arg)
    let l:Result=a:Arg
    for l:Trans in a:Trans
        let curarg=s:F.tran._main(l:Trans, l:Result)
        unlet l:Result
        if type(curarg)==type(0)
            return 0
        endif
        let l:Result=curarg.result
    endfor
    return {"result": l:Result}
endfunction
"{{{3 tran._main
function s:F.tran._main(trans, Arg)
    let selfname="tran._main"
    "{{{4 Проверка аргументов
    if type(a:trans)!=type([])
        return s:F.main.eerror(selfname, "trans", ["tnlst"])
    elseif len(a:trans)!=2
        return s:F.main.eerror(selfname, "trans", ["tn2"])
    elseif type(a:trans[0])!=type("")
        return s:F.main.eerror(selfname, "trans", ["tnstr"])
    elseif !has_key(s:g.tran.transchecks, a:trans[0])
        return s:F.main.eerror(selfname, "trans", ["utran", a:trans[0]])
    endif
    "{{{4 Объявление переменных
    let [ttrans, l:Trans]=a:trans[0:1]
    "{{{4 Проверка трансформации
    if !eval(s:g.tran.transchecks[ttrans][0])
        return s:F.main.eerror(selfname, "tran",
                    \s:g.tran.transchecks[ttrans][1])
    endif
    "}}}4
    return call(s:F.tran[ttrans], [l:Trans, a:Arg], {})
endfunction
"{{{2 mod: simple, optional, prefixed, actions, aslist
"{{{3 s:g.mod
let s:g.mod={}
"{{{3 mod.actions: Проверка в зависимости от первого аргумента
function s:F.mod.actions(chk, args, shift)
    let selfname="mod.actions"
    "{{{4 Проверка аргументов
    if !has_key(a:chk, "actions")
        return self.eerror(selfname, "check", ["nact"])
    elseif type(a:chk.actions)!=type({})
        return self.eerror(selfname, "check", ["andct"])
    elseif a:shift>=len(a:args)
        return self.eerror(selfname, "value", ["aexp", a:shift])
    elseif type(a:args[a:shift])!=type("")
        return self.eerror(selfname, "value", ["estr", a:shift])
    endif
    "{{{4 Проверка, разрешены ли сокращения
    let allowtrun=1
    if has_key(a:chk, "allowtrun")
        if index([0, 1], a:chk.allowtrun)==-1
            return self.eerror(selfname, "check", ["kbool"])
        endif
        let allowtrun = a:chk.allowtrun
    endif
    "}}}4
    let action=tolower(a:args[a:shift])
    "{{{4 Получение действия, если разрешены сокращения
    if allowtrun
        let foundaction=self.gettrun(action, a:chk.actions)
        if type(foundaction)!=type("")
            return self.eerror(selfname, "value", ["uact", action, a:shift])
        endif
        let action=foundaction
    "{{{4 если не разрешены
    elseif !has_key(a:chk.actions, action)
        return self.eerror(selfname, "value", ["uact", action, a:shift])
    endif
    "{{{4 Получение аргументов
    let result=self._main(a:chk.actions[action], a:args, a:shift+1)
    if type(result)!=type([])
        return 0
    endif
    "}}}4
    return [action]+result
endfunction
"{{{3 mod.simple: Простая модель
function s:F.mod.simple(chk, args, shift)
    let selfname="mod.simple"
    "{{{4 Проверяем на наличие ключа «required»
    if !has_key(a:chk, "required")
        return self.eerror(selfname, "check", ["nreq"])
    endif
    "{{{4 Проверяем количество аргументов
    if len(a:args)!=(len(a:chk.required)+a:shift)
        return self.eerror(selfname, "value", ["ilen",
                    \len(a:chk.required)+a:shift, len(a:args)],
                    \["rlen"])
    endif
    "{{{4 Получение аргументов
    let result=self.getrequired(a:chk, a:args, a:shift)
    if type(result)!=type({})
        return 0
    endif
    return result.result
    "}}}4
endfunction
"{{{3 mod.optional: Простая модель с необязательными аргументами
"                          и значениями по-умолчанию
function s:F.mod.optional(chk, args, shift)
    let selfname="mod.optional"
    "{{{4 Получаем обязательные аргументы
    let result=self.getrequired(a:chk, a:args, a:shift)
    if type(result)!=type({})
        return 0
    endif
    let reqlen=result.last+1
    let args=result.result
    unlet result
    "{{{4 Получаем необязательные аргументы
    let result=self.getoptional(a:chk, a:args, reqlen)
    if type(result)!=type({})
        return 0
    endif
    let reqlen=result.last+1
    let args+=result.result
    unlet result
    "{{{4 Получаем «следующие» аргументы
    let result=self.getnext(a:chk, a:args, reqlen)
    if type(result)!=type({})
        return 0
    endif
    let args+=result.result
    "{{{4 Убеждаемся, что все аргументы вписываются в модель
    if (result.last)!=(len(a:args)-1)
        if (len(a:args)-1)>result.last
            return self.eerror(selfname, "value",
                        \      [">len", result.last+1, len(a:args)],
                        \      ["mlen"])
        endif
        return self.eerror(selfname, "value",
                    \      ["ilen", result.last+1, len(a:args)])
    endif
    "}}}4
    return args
endfunction
"{{{3 mod.prefixed
" Простая модель, за которой следуют в произвольном порядке необязательные 
" аргументы, опозноваемые по префиксу.
function s:F.mod.prefixed(chk, args, shift)
    let selfname="mod.prefixed"
    "{{{4 Получаем обязательные аргументы
    let result=self.getrequired(a:chk, a:args, a:shift)
    if type(result)!=type({})
        return 0
    endif
    let shift=result.last+1
    let args=result.result
    unlet result
    "{{{4 ?chk
    let ochk={}
    let rchk={}
    if has_key(a:chk, "prefoptional")
        let ochk=copy(a:chk.prefoptional)
    endif
    if has_key(a:chk, "prefrequired")
        let rchk=copy(a:chk.prefrequired)
    endif
    let duppref=filter(keys(rchk), 'has_key(ochk, v:val)')
    if !empty(duppref)
        return self.error(selfname, "check", ["dupor", string(duppref)])
    endif
    let chk=keys(ochk)+keys(rchk)
    let noaltchk=copy(chk)
    let hasaltpref=has_key(a:chk, "altpref")
    if hasaltpref
        let chk+=filter(copy(a:chk.altpref), 'type(v:val)=='.type("").
                    \                    ' && index(chk, v:val)==-1')
    endif
    "{{{4 Получаем необязательные аргументы
    let result=self.getoptional(a:chk, a:args, shift, chk)
    if type(result)!=type({})
        return 0
    endif
    let args+=result.result
    let shift=result.last+1
    "{{{4 Проверка, разрешены ли сокращения
    let haspreflist=has_key(a:chk, "preflist")
    let plcheck=["alllst", ["in", chk], s:g.p.emsg.pl]
    if haspreflist
        let i=0
        for pref in a:chk.preflist
            if type(pref)!=type("")
                return self.eerror(selfname, "check", ["pnstr", i])
            elseif index(noaltchk, pref)==-1
                return self.eerror(selfname, "check", ["upref", i, pref])
            endif
            let i+=1
        endfor
    endif
    let allowtrun=(empty(result.result) && !haspreflist)
    unlet result
    if allowtrun && has_key(a:chk, "allowtrun")
        if index([0, 1], a:chk.allowtrun)==-1
            return self.eerror(selfname, "check", ["kbool"])
        endif
        let allowtrun = a:chk.allowtrun
    endif
    "{{{4 Собственно, префиксы
    let largs=len(a:args)
    if has_key(a:chk, "prefoptional") || has_key(a:chk, "prefrequired") ||
                \has_key(a:chk, "altpref")
        "{{{5 Объявление переменных
        let result={}
        let pref=""
        let arg=""
        let inlist=0
        let isalt=0
        "{{{5 Получение префиксов
        while shift<largs
            "{{{6 Если ещё нет префикса
            if pref==#""
                unlet pref
                let pref=a:args[shift]
                let inlist=0
                let isalt=0
                if type(pref)!=type("")
                    return self.eerror(selfname, "value", ["estr", shift])
                elseif allowtrun
                    let foundpref=self.gettrun(pref, chk, !hasaltpref)
                    if type(foundpref)!=type("")
                        if hasaltpref && pref[:1]==#'no'
                            let foundpref=self.gettrun(pref[2:],
                                        \              a:chk.altpref)
                            if type(foundpref)!=type("")
                                return self.eerror(selfname, "value",
                                            \      ["upr", pref, shift])
                            endif
                            let result[foundpref]=0
                            let foundpref=""
                        else
                            return self.eerror(selfname, "value",
                                        \      ["upr", pref, shift])
                        endif
                    elseif hasaltpref
                        let isalt=(index(a:chk.altpref, foundpref)!=-1)
                        if isalt
                            let result[foundpref]=1
                            if index(noaltchk, foundpref)==-1
                                let foundpref=""
                            endif
                        endif
                    endif
                    let pref=foundpref
                    unlet foundpref
                elseif index(chk, pref)==-1
                    if hasaltpref && pref[:1]==#'no' &&
                                \index(a:chk.altpref, pref[2:])!=-1
                        let result[pref[2:]]=0
                        let pref=""
                    else
                        return self.eerror(selfname, "value",
                                    \      ["upr", pref, shift])
                    endif
                elseif hasaltpref
                    let isalt=(index(a:chk.altpref, pref)!=-1)
                    if isalt
                        let result[pref]=1
                        if index(noaltchk, pref)==-1
                            let pref=""
                        endif
                    endif
                endif
                if haspreflist && index(a:chk.preflist, pref)!=-1
                    let result[pref]=[]
                    let inlist=1
                    if has_key(ochk, pref)
                        let listchk=ochk[pref][0]
                        unlet ochk[pref]
                    elseif has_key(rchk, pref)
                        let listchk=rchk[pref]
                        unlet rchk[pref]
                    else
                        return self.eerror(selfname, "check",
                                    \      ["nropr", pref])
                    endif
                endif
                let shift+=1
                continue
            endif
            "{{{6 Получение аргумента
            unlet arg
            let arg=a:args[shift]
            "{{{7 Если мы внутри списка,
            " то надо остановиться на аргументе, являющемся префиксом
            if (inlist || isalt) &&
                        \(index(chk, arg)!=-1 ||
                        \ (arg[:1]==#'no' &&
                        \  index(a:chk.altpref, arg[2:])!=-1))
                let pref=""
                if inlist
                    unlet listchk
                endif
                continue
            endif
            "{{{7 Получения значения, соответствующего префиксу
            if inlist
                let gres=s:F.comm.getarg(listchk, arg)
            elseif has_key(ochk, pref)
                let gres=s:F.comm.getarg(ochk[pref][0], arg)
                unlet ochk[pref]
            elseif has_key(rchk, pref)
                let gres=s:F.comm.getarg(rchk[pref], arg)
                unlet rchk[pref]
            elseif isalt
                let pref=""
                continue
            else
                return self.eerror(selfname, "value", ["udpr", shift-1, pref])
            endif
            "{{{7 Запись полученного значения
            if type(gres)!=type({})
                if isalt
                    let pref=""
                    unlet gres
                    continue
                endif
                return self.eerror(selfname, "value", ["eival", shift+1])
            elseif has_key(gres, "result")
                if inlist
                    call add(result[pref], gres.result)
                else
                    let result[pref]=gres.result
                    let pref=""
                endif
            endif
            unlet gres
            "}}}6
            let shift+=1
        endwhile
        "{{{5 Проверка завершенности
        if pref!=#"" && !(inlist || isalt)
            return self.eerror(selfname, "value", ["ina", len(a:args)])
        endif
        "{{{5 Удаление полученных префиксов
        call filter(rchk, '!has_key(result, v:key)')
        call filter(ochk, '!has_key(result, v:key)')
        "{{{5 Проверка наличия всех обязательных префиксов
        if !empty(rchk)
            return self.eerror(selfname, "value", ["pmis",
                        \      join(keys(rchk), s:g.p.rq.", ".s:g.p.lq)])
        endif
        "{{{5 Получение неуказанных необязательных префиксов
        for pref in keys(ochk)
            let gres=s:F.comm.getarg(ochk[pref][1], ochk[pref][2])
            if type(gres)!=type({})
                return self.eerror(selfname, "value", ["eoval", pref])
            elseif has_key(gres, "result")
                let result[pref]=gres.result
            endif
            unlet gres
        endfor
        "{{{5 Получение «альтернативных» префиксов
        if hasaltpref
            for pref in a:chk.altpref
                if !has_key(result, pref)
                    let result[pref]=0
                endif
            endfor
        endif
        "}}}5
        call add(args, result)
    else
        if shift!=largs
            if largs>shift
                return self.eerror(selfname, "value",
                            \      [">len", shift, largs],
                            \      ["mlen"])
            endif
            return self.eerror(selfname, "value",
                        \      ["ilen", shift, largs],
                        \      ["mlen"])
        endif
    endif
    "}}}4
    return args
endfunction
"{{{3 mod.aslist Проверить оставшиеся аргументы как один аргумент
function s:F.mod.aslist(chk, args, shift)
    let selfname="mod.aslist"
    let args=a:args[(a:shift):]
    if !(type(a:chk)==type({}) && has_key(a:chk, "check"))
        return 0
    endif
    let gres=s:F.comm.getarg(a:chk.check, args)
    if type(gres)!=type({})
        return self.eerror(selfname, "value", ["lival", a:shift])
    elseif has_key(gres, "result")
        return gres.result
    endif
    return []
endfunction
"{{{2 cchk: _main, gettrun, getoptional, getrequired
"{{{3 cchk.gettrun
function s:F.cchk.gettrun(trun, fulls, ...)
    let selfname="cchk.gettrun"
    let doerror=get(a:000, 0, 1)
    if type(a:fulls)==type({})
        let fulls=keys(a:fulls)
    else
        let fulls=a:fulls
    endif
    if index(fulls, a:trun)!=-1
        return a:trun
    endif
    let ltrun=len(a:trun)-1
    let fullsfound=0
    for full in fulls
        if full[:ltrun]==#a:trun
            let fullsfound+=1
            let foundfull=full
            if fullsfound>1
                return self.eerror(selfname, "value", ["amb", a:trun])
            endif
        endif
    endfor
    if exists("foundfull")
        return foundfull
    endif
    if doerror
        return self.eerror(selfname, "value", ["nfull", a:trun])
    endif
    return 0
endfunction
"{{{3 cchk.getoptional
function s:F.cchk.getoptional(chk, args, reqlen, ...)
    let selfname="cchk.getoptional"
    "{{{4 Проверяем наличие ключа «optional»
    if !has_key(a:chk, "optional")
        return {"last": a:reqlen-1, "result": []}
    endif
    "{{{4 Проверяем, надо ли останавливаться
    if !empty(a:000)
        let stop='index(a:000[0], a:args[i])!=-1'
    endif
    "{{{4 Объявление переменных
    let i=a:reqlen
    let args=[]
    let largs=len(a:args)
    let last=i-1
    "{{{4 Основной цикл: получение аргументов
    for check in a:chk.optional
        "{{{5 Проверяем длину check
        if len(check)!=3
            return self.eerror(selfname, "mod", ["ilen", 3, len(check)])
        endif
        "{{{5 Остановка (если требуется)
        if i!=-1 && i<largs && exists("stop") && eval(stop)
            let i=-1
        endif
        "{{{5 Аргументы для функции получения аргумента
        if i<largs && i!=-1
            let gachk=check[0]
            let l:Gaarg=a:args[i]
            let last=i
        else
            let gachk=check[1]
            let l:Gaarg=check[2]
        endif
        "{{{5 Получение аргумента
        let gres=s:F.comm.getarg(gachk, l:Gaarg)
        if type(gres)!=type({})
            return self.eerror(selfname, "value", ["eival", i])
        elseif has_key(gres, "result")
            call add(args, gres.result)
        endif
        unlet gres
        unlet gachk
        unlet l:Gaarg
        "}}}5
        let i+=1
    endfor
    "}}}4
    return {"last": last, "result": args}
endfunction
"{{{3 cchk.getrequired
function s:F.cchk.getrequired(chk, args, shift)
    let selfname="cchk.getrequired"
    "{{{4 Проверяем наличие ключа «required»
    if !has_key(a:chk, "required")
        return {"result": [], "last": a:shift-1}
    endif
    "{{{4 Проверяем длину аргументов
    if len(a:args)<(len(a:chk.required)+a:shift)
        return self.eerror(selfname, "value",
                    \["<len", (len(a:chk.required)+a:shift), len(a:args)])
    endif
    "{{{4 Объявление переменных
    let args=[]
    let i=a:shift
    let last=i-1
    "{{{4 Основной цикл: получение аргументов
    for check in a:chk.required
        let last=i
        let gres=s:F.comm.getarg(check, a:args[i])
        if type(gres)!=type({})
            return self.eerror(selfname, "value", ["eival", i])
        elseif has_key(gres, "result")
            call add(args, gres.result)
        endif
        unlet gres
        let i+=1
    endfor
    "}}}4
    return {"result": args, "last": last}
endfunction
"{{{3 cchk.getnext
function s:F.cchk.getnext(chk, args, shift)
    let selfname="cchk.getnext"
    "{{{4 Проверяем наличие ключа «next»
    if !has_key(a:chk, "next")
        return {"result": [], "last": a:shift-1}
    endif
    "{{{4 Основной цикл: проверка аргументов
    let args=[]
    let i=a:shift
    for l:Arg in a:args[(a:shift):]
        let gres=s:F.comm.getarg(a:chk.next, l:Arg)
        if type(gres)!=type({})
            return self.eerror(selfname, "value", ["eival", i])
        elseif has_key(gres, "result")
            call add(args, gres.result)
        endif
        unlet gres
        let i+=1
    endfor
    "}}}4
    return {"result": args, "last": len(a:args)-1}
endfunction
"{{{3 cchk._main: Проверить аргументы команды
function s:F.cchk._main(chk, args, ...)
    let selfname="cchk._main"
    if type(a:args)!=type([])
        return self.eerror(selfname, "value", ["lchk"])
    endif
    if type(a:chk)!=type({})
        return self.eerror(selfname, "check", ["cdict"])
    elseif !has_key(a:chk, "model")
        return self.eerror(selfname, "check", ["nmod"])
    elseif type(a:chk.model)!=type("")
        return self.eerror(selfname, "check", ["modns"])
    elseif !has_key(s:F.mod, a:chk.model)
        return self.eerror(selfname, "check", ["umod", a:chk.model])
    endif
    let shift=0
    if len(a:000)
        let shift=a:000[0]
    endif
    return call(s:F.mod[a:chk.model], [a:chk, a:args, shift], self)
endfunction
"{{{3 cchk._main_init
let s:g.cchk={}
let s:F.cchk.eerror=s:F.main.eerror
let s:F.achk.echoerrors=s:F.main.echoerrors
let s:g.cchk.initdict=copy(s:F.cchk)
let s:F.cchk.doredir=0
function s:F.cchk._main_init(...)
    let initdict=copy(s:g.cchk.initdict)
    let initdict.doredir = get(self, "doredir", 0)
    let initdict.errors  = get(self, "errors", [])
    return call(s:F.cchk._main, a:000, initdict)
endfunction
"{{{2 achk: _main
"{{{3 s:g.achk
let s:g.achk={}
let s:g.achk.error=""
"{{{4 Простые проверки:
let s:g.achk.simplechecks={
            \   "in": ["index(a:Chk, a:Arg)!=-1",
            \          "['notin', s:F.stuf.string(a:Chk)], ".
            \          "s:F.stuf.string(a:Arg)"],
            \"regex": ["type(a:Arg)==type('') && a:Arg=~#a:Chk",
            \          "['nreg', s:F.stuf.string(a:Chk)], ".
            \          "s:F.stuf.string(a:Arg)"],
            \ "type": ["type(a:Arg)==a:Chk",
            \          "['type'], type(a:Arg).'≠'.a:Chk"],
            \ "bool": ["index([0, 1], a:Arg)!=-1", "['bool']"],
            \"keyof": ["type(a:Arg)==type('') && has_key(a:Chk, a:Arg)",
            \          "['nkey', s:F.stuf.string(a:Arg)]"],
            \ "hkey": ["type(a:Arg)==type({}) && has_key(a:Arg, a:Chk)",
            \          "['key', a:Chk]"],
            \"equal": ["type(a:Arg)==type(a:Chk) && a:Arg==#a:Chk",
            \          "['neq', s:F.stuf.string(a:Chk)]"],
        \}
for s:C in keys(s:g.achk.simplechecks)
    execute      "function s:F.achk.".s:C."(Chk, Arg)\n".
                \"    let selfname='achk.".s:C."'\n".
                \"    if ".s:g.achk.simplechecks[s:C][0]."\n".
                \"        return 1\n".
                \"    endif\n".
                \"    return self.eerror(selfname, 'value', ".
                \           s:g.achk.simplechecks[s:C][1].")\n".
                \"endfunction"
endfor
unlet s:C
"{{{3 achk.func:
let s:F.achk._call=load#CreateDictFunction('Chk, Arg',
            \'return !!call(a:Chk, [a:Arg], {})')
function s:F.achk.func(Chk, Arg)
    let selfname="achk.func"
    try
        return !!call(self._call, [a:Chk, a:Arg], {})
    catch
        return self.eerror(selfname, "chk", ["efunc", v:exception])
    endtry
endfunction
"{{{3 achk.eval:
let s:F.achk._eval=load#CreateDictFunction('chk, Arg', 'return eval(a:chk)')
function s:F.achk.eval(chk, Arg)
    let selfname="achk.eval"
    try
        return !!call(self._eval, [a:chk, a:Arg], {})
    catch
        return self.eerror(selfname, "chk", ["eexpr", v:exception])
    endtry
endfunction
"{{{3 achk.map
function s:F.achk.map(chk, Arg)
    let selfname="achk.map"
    if len(a:chk)!=2
        return self.eerror(selfname, "chk", ["ilen", 2, len(a:Arg)])
    elseif type(a:chk[1])!=type([])
        return self.eerror(selfname, "chk", ["dict"])
    endif
    let i=0
    for l:Check in a:chk[1]
        if !self._main([a:chk[0], l:Check], a:Arg)
            return self.eerror(selfname, "chk", ["chkf", i])
        endif
        let i+=1
    endfor
    return 1
endfunction
"{{{3 achk.allorno
function s:F.achk.allorno(chk, Arg)
    let selfname="achk.allorno"
    let matchcount=0
    let curcheck=0
    for l:Check in a:chk
        let curcheck+=1
        let self.doredir+=1
        if !self._main(l:Check, a:Arg)
            if matchcount
                let self.doredir-=1
                let self.errors=[]
                return self.eerror(selfname, "value",
                            \      ["chkf", curcheck])
            endif
        else
            let matchcount+=1
            if matchcount < curcheck
                let self.doredir-=1
                call self.echoerrors()
                return self.eerror(selfname, "value",
                            \      ["chks", curcheck])
            endif
        endif
        let self.doredir-=1
    endfor
    return 1
endfunction
"{{{3 achk.var:    Имя переменной
"{{{4 s:g.achk.var
let s:g.achk.var={
            \ "buffer": "a:Arg=~#'^b:'",
            \ "window": "a:Arg=~#'^w:'",
            \"tabpage": "a:Arg=~#'^t:'",
            \ "global": "a:Arg=~#'^g:'",
            \    "vim": "a:Arg=~#'^v:'",
            \ "option": "a:Arg=~#'^&'",
            \    "any": "1",
        \}
"}}}4
function s:F.achk.var(chk, Arg)
    let selfname="achk.var"
    "{{{4 Проверка аргументов
    let checks=split(a:chk, ',')
    "{{{5 Тип
    if type(a:Arg)!=type("")
        return self.eerror(selfname, "value", ["str"])
    "{{{5 Начало
    elseif a:Arg!~'^\%(\l:\|&\)'
        return self.eerror(selfname, "value", ["vars"], a:Arg)
    elseif a:Arg=~#'^[lsa]:'
        return self.eerror(selfname, "value", ["varls"], a:Arg)
    "{{{5 Ограничения
    elseif len(checks)
        let result=0
        for check in checks
            "{{{6 Неизвестная проверка
            if !has_key(s:g.achk.var, check)
                return self.eerror(selfname, "chk", ["uvt"], check)
            endif
            "}}}6
            if eval(s:g.achk.var[check])
                let result=1
                break
            endif
        endfor
        if !result
            return self.eerror(selfname, "value", ["ivar"], a:Arg)
        endif
    endif
    "{{{4 Проверка существования
    if !exists(a:Arg)
        return self.eerror(selfname, "value", ["varne"], a:Arg)
    endif
    "}}}4
    return 1
endfunction
"{{{3 achk.isfunc: Ссылка на функцию
function s:F.achk.isfunc(chk, Arg)
    let selfname="achk.isfunc"
    let targ=type(a:Arg)
    if !a:chk && targ!=2
        return self.eerror(selfname, "value", ["func"])
    elseif a:chk && (targ!=2 && targ!=type(""))
        return self.eerror(selfname, "value", ["funcs"])
    elseif targ==2 && !exists('*a:Arg')
        return self.eerror(selfname, "value",
                    \["cfunc", substitute(string(a:Arg), '^.*''\(.\{-}\)''.*',
                    \                     '\1', '')])
    elseif targ==type("")
        try
            if !s:F.achk._eval('exists("*".a:Arg)', a:Arg)
                return self.eerror(selfname, "value", ["fnex", a:Arg])
            endif
        catch /^Vim(return):E129/
            return self.eerror(selfname, "value", ["ifn", a:Arg])
        endtry
    endif
    return 1
endfunction
"{{{3 achk.any:    Любое значение
function s:F.achk.any(...)
    return 1
endfunction
"{{{3 achk.and:    Список проверок
function s:F.achk.and(chk, Arg)
    for chk in a:chk
        if !self._main(chk, a:Arg)
            return 0
        endif
    endfor
    return 1
endfunction
"{{{3 achk.or:     Список проверок
function s:F.achk.or(chk, Arg)
    let self.doredir+=1
    try
        for chk in a:chk
            if self._main(chk, a:Arg)
                return 1
            endif
        endfor
    finally
        let self.doredir-=1
    endtry
    call self.echoerrors()
    return 0
endfunction
"{{{3 achk.not:    Обратная проверка
function s:F.achk.not(chk, Arg)
    let self.doredir+=1
    try
        return !self._main(a:chk, a:Arg)
    finally
        let self.doredir-=1
        let self.errors=[]
    endtry
endfunction
"{{{3 achk.chklst: Проверить список с фиксированным количеством элементов
function s:F.achk.chklst(chk, Arg)
    let selfname="achk.chklst"
    "{{{4 Проверка аргументов
    if type(a:Arg)!=type([])
        return self.eerror(selfname, "value", ["list"])
    elseif len(a:Arg)!=len(a:chk)
        return self.eerror(selfname, "value", ["ilen", len(a:chk),
                    \                          len(a:Arg)])
    endif
    "{{{4 Проверка значения
    let i=0
    for l:Arg in a:Arg
        if !self._main(a:chk[i], l:Arg)
            return self.eerror(selfname, "value", ["elval", i])
        endif
        unlet l:Arg
        let i+=1
    endfor
    "}}}4
    return 1
endfunction
"{{{3 achk.optlst:
function s:F.achk.optlst(chk, Arg)
    let selfname="achk.optlst"
    if type(a:Arg)!=type([])
        return self.eerror(selfname, "value", ["list"])
    elseif len(a:chk)<2
        return self.eerror(selfname, "check", ["<len", 2, len(a:chk)])
    elseif len(a:Arg)<len(a:chk[0])
        return self.eerror(selfname, "value", ["<len", len(a:chk[0]),
                    \                          len(a:Arg)])
    elseif len(a:Arg) > (len(a:chk[0])+len(a:chk[1]))
        return self.eerror(selfname, "value",
                    \      [">len", (len(a:chk[0])+len(a:chk[1])),
                    \       len(a:Arg)])
    endif
    let i=0
    for check in a:chk[0]
        if !self._main(a:chk[0][i], a:Arg[i])
            return self.eerror(selfname, "value", ["elval", i])
        endif
        let i+=1
    endfor
    let j=0
    let larg=len(a:Arg)
    for check in a:chk[1]
        if i==larg
            return 1
        endif
        if !self._main(a:chk[1][j], a:Arg[i])
            return self.eerror(selfname, "value", ["elval", i])
        endif
        let j+=1
        let i+=1
    endfor
    return 1
endfunction
"{{{3 achk.alllst: Проверить каждый элемент в списке
function s:F.achk.alllst(chk, Arg)
    let selfname="achk.alllst"
    "{{{4 Проверка аргумент: список
    if type(a:Arg)!=type([])
        return self.eerror(selfname, "value", ["list"])
    endif
    "{{{4 Проверка списка
    let i=0
    for l:Arg in a:Arg
        if !self._main(a:chk, l:Arg)
            return self.eerror(selfname, "value", ["eival", i])
        endif
        unlet l:Arg
        let i+=1
    endfor
    "}}}4
    return 1
endfunction
"{{{3 achk.num:    Проверить число
function s:F.achk.num(chk, Arg)
    let selfname="achk.num"
    "{{{4 Проверить тип
    let tchk=type(a:chk[0])
    if tchk==type("")
        let tchk=type(a:chk[1])
    endif
    if tchk==type(0)
        if type(a:Arg)!=type(0)
            return self.eerror(selfname, "value", ["int"], a:Arg)
        endif
    elseif tchk==type(0.0)
        if type(a:Arg)!=type(0) && type(a:Arg)!=type(0.0)
            return self.eerror(selfname, "value", ["num"])
        endif
    endif
    "{{{4 Нижняя граница
    if type(a:chk[0])!=type("")
        if a:Arg<a:chk[0]
            return self.eerror(selfname, "value", ["uf", a:chk[0]], a:Arg)
        endif
    endif
    "{{{4 Верхняя граница
    if len(a:chk)==2
        if a:Arg>a:chk[1]
            return self.eerror(selfname, "value", ["of", a:chk[1]], a:Arg)
        endif
    endif
    "}}}4
    return 1
endfunction
"{{{3 achk.nums:   Проверить число, записанное в виде строки
function s:F.achk.nums(chk, Arg)
    let selfname="achk.nums"
    if type(a:Arg)!=type("")
        return self.eerror(selfname, "value", ["str"])
    elseif a:Arg!~#'^[+-]\=\(\d\+\(\.\d\+\(e[+-]\=\d\+\)\=\)\=\|0x\d\+\)$'
        return self.eerror(selfname, "value", ["nums"])
    endif
    try
        let e=eval(a:Arg)
    catch
        return self.eerror(selfname, "value", ["evalf"], v:exception)
    endtry
    return self.num(a:chk, e)
endfunction
"{{{3 achk.len:    Проверить длину
function s:F.achk.len(chk, Arg)
    let selfname="achk.len"
    let larg=len(a:Arg)
    if type(a:Arg)!=type([])
        return self.eerror(selfname, "value", ["list"])
    elseif type(a:chk[0])!=type(0) || a:chk[0]<0
        return self.eerror(selfname, "chk",   ["uint"])
    elseif larg<a:chk[0]
        return self.eerror(selfname, "value", ["tslst", a:chk[0], larg])
    endif
    if len(a:chk)==2
        if type(a:chk[1])!=type(0) || a:chk[1]<0
            return self.eerror(selfname, "chk", ["uint"])
        elseif a:chk[1]<a:chk[0]
            return self.eerror(selfname, "chk", ["irng", a:chk[0],
                        \                                a:chk[1])])
        elseif larg>a:chk[1]
            return self.eerror(selfname, "value", ["tllst",
                        \                          a:chk[1], larg])
        endif
    endif
    return 1
endfunction
"{{{3 achk.dict:   Проверить словарь
function s:F.achk.dict(chk, Arg)
    let selfname="achk.dict"
    if type(a:Arg)!=type({})
        return self.eerror(selfname, "value", ["dict"])
    endif
    for key in keys(a:Arg)
        let passed=0
        for check in a:chk
            if len(check)!=2
                return self.eerror(selfname, "chk", ["ilen", 2,
                            \                        len(check)])
            endif
            let self.doredir+=1
            if self._main(check[0], key)
                let self.doredir-=1
                if !self._main(check[1], a:Arg[key])
                    return self.eerror(selfname, "value", ["kival", key])
                else
                    let passed=1
                    break
                endif
            endif
            let self.doredir-=1
        endfor
        if !passed
            call self.echoerrors()
            return self.eerror(selfname, "value", ["ukey", key])
        endif
    endfor
    return 1
endfunction
"{{{3 achk.file:   Проверить файл
function s:F.achk.file(chk, Arg)
    let selfname="achk.file"
    if type(a:Arg)!=type("")
        return self.eerror(selfname, "value", ["str"])
    endif
    if a:chk==#"r"
        return filereadable(a:Arg)
    elseif a:chk==#"rw"
        return filewritable(a:Arg)==1
    elseif a:chk==#"dw"
        return filewritable(a:Arg)==2
    elseif a:chk==#"d"
        return isdirectory(a:Arg)
    elseif a:chk==#"x"
        return executable(fnamemodify(a:Arg, ':p'))
    elseif a:chk==#"w"
        return s:F.stuf.checkwr(a:Arg)
    endif
    return self.eerror(selfname, "chk", ["ufct"])
endfunction
"{{{3 achk.isreg:  Проверить, является ли a:Arg регулярным выражением
function s:F.achk.isreg(Chk, Arg)
    let selfname="achk.isreg"
    if type(a:Arg)!=type("")
        return self.eerror(selfname, "value", ["str"])
    endif
    try
        call matchstr("", a:Arg)
    catch
        return self.eerror(selfname, "value", ["ireg", a:Arg], v:exception)
    endtry
    return 1
endfunction
"{{{3 achk.hlgroup: Проверить, является ли a:Arg именем группы подсветки
function s:F.achk.hlgroup(Chk, Arg)
    let selfname="achk.hlgroup"
    if type(a:Arg)!=type("")
        return self.eerror(selfname, "value", ["str"])
    elseif a:Arg!~#'^[a-zA-Z0-9_]\+$'
        return self.eerror(selfname, "value", ["hid"], a:Arg)
    elseif exists("*hlexists")
        if !hlexists(a:Arg)
            return self.eerror(selfname, "value", ["hnf"], a:Arg)
        endif
        return 1
    elseif exists("*highlight_exists")
        if !highlight_exists(a:Arg)
            return self.eerror(selfname, "value", ["hnf"], a:Arg)
        endif
        return 1
    endif
    try
        execute "silent highlight ".a:Arg
    catch
        return self.eerror(selfname, "value", ["hnf"], a:Arg)
    endtry
    return 1
endfunction
"{{{3 achk._main:  Проверить значение
"{{{4 Проверка проверок
let s:g.achk.chkchecks={
            \"allorno": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \    "map": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \     "in": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \    "and": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \     "or": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \    "not": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \    "num": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \   "nums": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \ "chklst": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \ "optlst": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \ "alllst": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \   "dict": ["type(l:Chk)==type([])", s:g.p.emsg.list           ],
            \    "len": ["type(l:Chk)==type([]) && len(l:Chk) && len(l:Chk)<=2",
            \                                     s:g.p.emsg.list           ],
            \  "regex": ["self.isreg('', l:Chk)",
            \                                     s:g.p.emsg.str            ],
            \   "eval": ["type(l:Chk)==type('')", s:g.p.emsg.str            ],
            \   "hkey": ["type(l:Chk)==type('')", s:g.p.emsg.str            ],
            \    "var": ["type(l:Chk)==type('')", s:g.p.emsg.str            ],
            \   "file": ["type(l:Chk)==type('')", s:g.p.emsg.str            ],
            \  "keyof": ["type(l:Chk)==type({})", s:g.p.emsg.dict           ],
            \   "func": ["self.isfunc(1, l:Chk)",
            \                                     s:g.p.emsg.func           ],
            \   "type": ["type(l:Chk)==type(0) && l:Chk>=0 && l:Chk<=5",
            \                                     s:g.p.emsg.int            ],
            \ "isfunc": ["type(l:Chk)==type(0) && (l:Chk==1 || l:Chk==0)",
            \                                     s:g.p.emsg.bool           ],
            \   "bool": ["1",                     ""                        ],
            \    "any": ["1",                     ""                        ],
            \  "equal": ["1",                     ""                        ],
            \  "isreg": ["1",                     ""                        ],
            \"hlgroup": ["1",                     ""                        ],
        \}
let s:g.achk.chkroot=[["type(a:chk)==type([])",          s:g.p.emsg.list],
            \         ["len(a:chk)==2 || len(a:chk)==3", s:g.p.emsg.ilen],
            \         ["type(a:chk[0])==type('')",       s:g.p.emsg.cstr],
            \         ["has_key(s:g.achk.chkchecks, a:chk[0])",
            \                                            s:g.p.emsg.uchk],
            \]
"}}}4
function s:F.achk._main(chk, Arg)
    let selfname="achk._main"
    "{{{4 Проверка проверки
    if get(self, "checkchk", 0)
        for check in s:g.achk.chkroot
            if !eval(check[0])
                return self.eerror(selfname, "chk", check[1],
                            \      s:F.stuf.string(a:chk))
            endif
        endfor
    endif
    "{{{4 Объявление переменных
    let emsg=((len(a:chk)==3)?(a:chk[2]):(s:g.p.emsg.ival))
    let [tchk, l:Chk]=a:chk[0:1]
    "{{{4 Проверка проверки
    if get(self, "checkchk", 0) && !eval(s:g.achk.chkchecks[tchk][0])
        return self.eerror(selfname, "chk", ["ichk"],
                    \s:g.achk.chkchecks[tchk][1])
    endif
    "{{{4 Проверка значения
    if self[tchk](l:Chk, a:Arg)
        return 1
    endif
    "}}}4
    return self.eerror(selfname, "value", emsg)
endfunction
"{{{3 achk._main_init
let s:F.achk.eerror=s:F.main.eerror
let s:F.achk.echoerrors=s:F.main.echoerrors
let s:g.achk.initdict=copy(s:F.achk)
let s:g.achk.initdict.checkchk=1
let s:F.achk.doredir=0
function s:F.achk._main_init(...)
    let initdict=copy(s:g.achk.initdict)
    let initdict.doredir = get(self, "doredir", 0)
    let initdict.errors  = get(self, "errors", [])
    return call(s:F.achk._main, a:000, initdict)
endfunction
"{{{2 Внешние дополнения
" let s:F.plug.stuf=s:F.plug.load.getfunctions("stuf")
"{{{1
lockvar! s:F
unlockvar 1 s:F.main
lockvar! s:g
unlockvar 1 s:g
unlockvar s:g.achk.error
unlockvar s:g.comm.rdict
" vim: ft=vim:ts=8:fdm=marker:fenc=utf-8


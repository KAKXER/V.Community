function _0x8ad6(_0x363bbf, _0x5f0077) {
    var _0x47831e = _0x4783();
    return _0x8ad6 = function(_0x8ad640, _0x590026) {
        _0x8ad640 = _0x8ad640 - 0x14d;
        var _0x1a1a30 = _0x47831e[_0x8ad640];
        return _0x1a1a30;
    }, _0x8ad6(_0x363bbf, _0x5f0077);
}

function _0x4783() {
    var _0x57840c = ['message', '341766oSWCRZ', '184HZBBPZ', 'focusTimer', 'hideInput', 'messages', 'http://chat/chatResult', 'templates', 'removeEventListener', 'moveOldMessageIndex', 'oldMessagesIndex', '9sZOzhu', 'stringify', 'which', 'focus', 'style', '^3<b>CHAT-WARN</b>:\x20^0{0}', 'includes', '100ALgRvw', '$refs', 'html', '9102810fgGQZa', 'scrollHeight', 'suggestions', '20kQmwAH', 'length', '#app_template', '962335xGYyTv', 'detail', 'offsetTop', 'name', 'startsWith', 'unshift', '10854038wATAfM', 'offsetHeight', 'push', '824805bQJxZU', 'input', 'showWindowTimer', 'oldMessages', 'filter', 'split', 'msg', 'scrollTop', 'value', '36ZrOXhZ', 'showWindow', 'addEventListener', 'resetShowWindowTimer', 'warn', 'showInput', 'app', 'clearShowWindowTimer', 'APP', '7DjNozp', 'listener', '2119660AbDhex', 'type', 'Tried\x20to\x20add\x20duplicate\x20template\x20\x27', '19157chjOgh', 'params'];
    _0x4783 = function() {
        return _0x57840c;
    };
    return _0x4783();
}
var _0x2f63d7 = _0x8ad6;
(function(_0x319f87, _0x2ce1f9) {
    var _0x50459f = _0x8ad6,
        _0x15cbd3 = _0x319f87();
    while (!![]) {
        try {
            var _0x193038 = parseInt(_0x50459f(0x154)) / 0x1 * (parseInt(_0x50459f(0x16e)) / 0x2) + -parseInt(_0x50459f(0x161)) / 0x3 * (-parseInt(_0x50459f(0x151)) / 0x4) + parseInt(_0x50459f(0x17a)) / 0x5 + -parseInt(_0x50459f(0x16b)) / 0x6 * (-parseInt(_0x50459f(0x14f)) / 0x7) + parseInt(_0x50459f(0x158)) / 0x8 * (parseInt(_0x50459f(0x157)) / 0x9) + -parseInt(_0x50459f(0x168)) / 0xa * (parseInt(_0x50459f(0x171)) / 0xb) + -parseInt(_0x50459f(0x183)) / 0xc * (parseInt(_0x50459f(0x177)) / 0xd);
            if (_0x193038 === _0x2ce1f9) break;
            else _0x15cbd3['push'](_0x15cbd3['shift']());
        } catch (_0x50df0f) {
            _0x15cbd3['push'](_0x15cbd3['shift']());
        }
    }
}(_0x4783, 0xe9b01), window[_0x2f63d7(0x14e)] = {
    'template': _0x2f63d7(0x170),
    'name': _0x2f63d7(0x189),
    'data'() {
        var _0x39131c = _0x2f63d7;
        return {
            'style': CONFIG[_0x39131c(0x165)],
            'showInput': ![],
            'showWindow': ![],
            'suggestions': [],
            'templates': CONFIG[_0x39131c(0x15d)],
            'message': '',
            'messages': [],
            'oldMessages': [],
            'oldMessagesIndex': -0x1
        };
    },
    'destroyed'() {
        var _0x26fe0b = _0x2f63d7;
        clearInterval(this['focusTimer']), window[_0x26fe0b(0x15e)](_0x26fe0b(0x156), this[_0x26fe0b(0x150)]);
    },
    'mounted'() {
        var _0x412da6 = _0x2f63d7;
        post('http://chat/loaded', JSON[_0x412da6(0x162)]({})), this['listener'] = window[_0x412da6(0x185)]('message', _0x1cf89a => {
            var _0x11e666 = _0x412da6;
            const _0x3a8f9e = _0x1cf89a['data'] || _0x1cf89a[_0x11e666(0x172)];
            this[_0x3a8f9e[_0x11e666(0x152)]] && this[_0x3a8f9e[_0x11e666(0x152)]](_0x3a8f9e);
        });
    },
    'watch': {
        'messages'() {
            var _0x5a4af0 = _0x2f63d7;
            this[_0x5a4af0(0x17c)] && clearTimeout(this['showWindowTimer']);
            this[_0x5a4af0(0x184)] = !![], this['resetShowWindowTimer']();
            const _0x30471a = this[_0x5a4af0(0x169)][_0x5a4af0(0x15b)];
            this['$nextTick'](() => {
                var _0x3ce1d1 = _0x5a4af0,
                    _0x383500 = document['getElementsByClassName'](_0x3ce1d1(0x180))[document['getElementsByClassName'](_0x3ce1d1(0x180))[_0x3ce1d1(0x16f)] - 0x1];
                (_0x30471a['scrollTop'] + _0x30471a[_0x3ce1d1(0x178)] > _0x383500[_0x3ce1d1(0x173)] - _0x383500['offsetHeight'] || !this[_0x3ce1d1(0x188)]) && (_0x30471a['scrollTop'] = _0x30471a[_0x3ce1d1(0x16c)]);
            });
        }
    },
    'methods': {
        'ON_OPEN'() {
            var _0x45191a = _0x2f63d7;
            this[_0x45191a(0x188)] = !![], this[_0x45191a(0x184)] = !![], this[_0x45191a(0x169)][_0x45191a(0x15b)][_0x45191a(0x181)] = this[_0x45191a(0x169)][_0x45191a(0x15b)][_0x45191a(0x16c)], this[_0x45191a(0x17c)] && clearTimeout(this['showWindowTimer']), this[_0x45191a(0x159)] = setInterval(() => {
                var _0x11a2b0 = _0x45191a;
                this['$refs']['input'] ? this[_0x11a2b0(0x169)][_0x11a2b0(0x17b)][_0x11a2b0(0x164)]() : clearInterval(this['focusTimer']);
            }, 0x64);
        },
        'ON_MESSAGE'({
            message: _0x493513
        }) {
            var _0x3677ee = _0x2f63d7;
            this[_0x3677ee(0x15b)][_0x3677ee(0x179)](_0x493513);
        },
        'ON_CLEAR'() {
            var _0x3ed60f = _0x2f63d7;
            this[_0x3ed60f(0x15b)] = [], this[_0x3ed60f(0x17d)] = [], this[_0x3ed60f(0x160)] = -0x1;
        },
        'ON_SUGGESTION_ADD'({
            suggestion: _0x548e5d
        }) {
            var _0x15f694 = _0x2f63d7;
            !_0x548e5d[_0x15f694(0x155)] && (_0x548e5d[_0x15f694(0x155)] = []), this[_0x15f694(0x16d)][_0x15f694(0x179)](_0x548e5d);
        },
        'ON_SUGGESTION_REMOVE'({
            name: _0x42e5cd
        }) {
            var _0x25fea1 = _0x2f63d7;
            this['suggestions'] = this['suggestions'][_0x25fea1(0x17e)](_0x74467e => _0x74467e[_0x25fea1(0x174)] !== _0x42e5cd);
        },
        'ON_TEMPLATE_ADD'({
            template: _0x13a739
        }) {
            var _0x42f679 = _0x2f63d7;
            this[_0x42f679(0x15d)][_0x13a739['id']] ? this[_0x42f679(0x187)](_0x42f679(0x153) + _0x13a739['id'] + '\x27') : this[_0x42f679(0x15d)][_0x13a739['id']] = _0x13a739[_0x42f679(0x16a)];
        },
        'warn'(_0x5cf750) {
            var _0x544d85 = _0x2f63d7;
            this['messages'][_0x544d85(0x179)]({
                'args': [_0x5cf750],
                'template': _0x544d85(0x166)
            });
        },
        'clearShowWindowTimer'() {
            clearTimeout(this['showWindowTimer']);
        },
        'hide'() {
            $("#app").css("opacity", "0");
        },
        'show'() {
            $("#app").css("opacity", "1");
        },
        'resetShowWindowTimer'() {
            var _0xf7672f = _0x2f63d7;
            this[_0xf7672f(0x14d)](), this[_0xf7672f(0x17c)] = setTimeout(() => {
                var _0x3193d4 = _0xf7672f;
                !this[_0x3193d4(0x188)] && (this[_0x3193d4(0x184)] = ![]);
            }, CONFIG['fadeTimeout']);
        },
        'keyUp'() {},
        'keyDown'(_0x3a7ef7) {
            var _0x137b73 = _0x2f63d7;
            if (_0x3a7ef7[_0x137b73(0x163)] === 0x26 || _0x3a7ef7[_0x137b73(0x163)] === 0x28) _0x3a7ef7['preventDefault'](), this[_0x137b73(0x15f)](_0x3a7ef7[_0x137b73(0x163)] === 0x26);
            else {
                if (_0x3a7ef7[_0x137b73(0x163)] === 0x21) {
                    var _0x2011bb = this[_0x137b73(0x169)][_0x137b73(0x15b)];
                    _0x2011bb[_0x137b73(0x181)] = _0x2011bb[_0x137b73(0x181)] - 0x64;
                } else {
                    if (_0x3a7ef7[_0x137b73(0x163)] === 0x22) {
                        var _0x2011bb = this['$refs'][_0x137b73(0x15b)];
                        _0x2011bb[_0x137b73(0x181)] = _0x2011bb[_0x137b73(0x181)] + 0x64;
                    } else {
                        if (_0x3a7ef7['which'] === 0x9) {
                            var _0x4a7715 = this[_0x137b73(0x169)][_0x137b73(0x17b)][_0x137b73(0x182)],
                                _0x59651c = this[_0x137b73(0x16d)][_0x137b73(0x17e)](_0x157990 => {
                                    var _0x2a07a0 = _0x137b73;
                                    if (!_0x157990[_0x2a07a0(0x174)][_0x2a07a0(0x175)](_0x4a7715)) {
                                        const _0x3cbb90 = _0x157990[_0x2a07a0(0x174)][_0x2a07a0(0x17f)]('\x20'),
                                            _0x1ff1fc = _0x4a7715[_0x2a07a0(0x17f)]('\x20');
                                        for (let _0x1686d7 = 0x0; _0x1686d7 < _0x1ff1fc[_0x2a07a0(0x16f)]; _0x1686d7 += 0x1) {
                                            if (_0x1686d7 >= _0x3cbb90[_0x2a07a0(0x16f)]) return _0x1686d7 < _0x3cbb90[_0x2a07a0(0x16f)] + _0x157990['params']['length'];
                                            if (_0x3cbb90[_0x1686d7] !== _0x1ff1fc[_0x1686d7]) return ![];
                                        }
                                    }
                                    return !![];
                                })['slice'](0x0, 0x1);
                            !this[_0x137b73(0x156)][_0x137b73(0x167)](_0x59651c[0x0][_0x137b73(0x174)]) && (this[_0x137b73(0x156)] = _0x59651c[0x0]['name']);
                        }
                    }
                }
            }
        },
        'moveOldMessageIndex'(_0x1fa4c0) {
            var _0x3f9852 = _0x2f63d7;
            if (_0x1fa4c0 && this['oldMessages'][_0x3f9852(0x16f)] > this[_0x3f9852(0x160)] + 0x1) this[_0x3f9852(0x160)] += 0x1, this[_0x3f9852(0x156)] = this[_0x3f9852(0x17d)][this[_0x3f9852(0x160)]];
            else {
                if (!_0x1fa4c0 && this[_0x3f9852(0x160)] - 0x1 >= 0x0) this[_0x3f9852(0x160)] -= 0x1, this[_0x3f9852(0x156)] = this[_0x3f9852(0x17d)][this[_0x3f9852(0x160)]];
                else !_0x1fa4c0 && this[_0x3f9852(0x160)] - 0x1 === -0x1 && (this['oldMessagesIndex'] = -0x1, this[_0x3f9852(0x156)] = '');
            }
        },
        'send'(_0x2221c3) {
            var _0x12859c = _0x2f63d7;
            this[_0x12859c(0x156)] !== '' ? (post(_0x12859c(0x15c), JSON['stringify']({
                'message': this[_0x12859c(0x156)]
            })), this[_0x12859c(0x17d)][_0x12859c(0x176)](this[_0x12859c(0x156)]), this[_0x12859c(0x160)] = -0x1, this[_0x12859c(0x15a)]()) : this[_0x12859c(0x15a)](!![]);
        },
        'hideInput'(_0x3ebde7 = ![]) {
            var _0x58df31 = _0x2f63d7;
            _0x3ebde7 && post('http://chat/chatResult', JSON['stringify']({
                'canceled': _0x3ebde7
            })), this[_0x58df31(0x156)] = '', this[_0x58df31(0x188)] = ![], clearInterval(this[_0x58df31(0x159)]), this[_0x58df31(0x186)]();
        }
    }
});
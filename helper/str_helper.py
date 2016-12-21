#-*- encoding: utf-8 -*-

import hashlib
import uuid
import sys
import urllib
from datetime import date, datetime, timedelta

def is_null_or_empty(str):
    return True if str == None or str == '' else False

def format_str_to_list_strip(str, sp):
    ls = str.split(sp)
    l = []
    for i in ls:
        s = i.strip()
        l.append(s)
    return l

def format_str_to_list_filter_empty(str, sp):
    ls = str.split(sp)
    l = []
    for i in ls:
        s = i.strip()
        if is_null_or_empty(s):
            continue
        l.append(s)
    return l

def get_md5(str):
    m = hashlib.md5(str)
    # m.digest()
    return m.hexdigest()

def get_sha1(str):
    m = hashlib.sha1(str)
    # m.digest()
    return m.hexdigest()


def get_uuid():
    return str(uuid.uuid1()).replace('-','')

def is_list_str_in(sourceList, target, isCasematters = True):
    ''' 
        判断list的str中是否含有target字符串
        sourceList：源list
        target：目标字符串
        isCasematters：是否区分大小写
    '''
    for source in sourceList:
        if True == isCasematters and target in source:
            return True
        if False == isCasematters and target.lower() in source.lower():
            return True
    return False




def format_url(url, params):
    if '?' in url:
        url = '%s&' % url
    else:
        url = '%s?' % url
    for k in params.keys():
        url = '%s%s=%s&' % (url, k, url_escape(params[k]))
    return url



def url_escape(value):
    """Returns a valid URL-encoded version of the given value."""
    return urllib.quote_plus(utf8(value))

_UTF8_TYPES = (bytes, type(None))

def utf8(value):
    """Converts a string argument to a byte string.
    If the argument is already a byte string or None, it is returned unchanged.
    Otherwise it must be a unicode string and is encoded as utf8.
    """
    if isinstance(value, _UTF8_TYPES):
        return value
    return value.encode("utf-8")


def get_url(url, params):
    type = False
    if '?' in url:
        type = True


def get_url_params(url):
    if 'POSTSTRING:' in url:
        return get_url_post_params(url)
    else:
        return get_url_get_params(url)

def get_url_get_params(url):
    us = url.strip().split('?')
    p = {}
    if len(us) < 2:
        return p

    uss = us[1].split('&')
    for u in uss:
        s = u.split('=')
        if len(s) < 2:
            continue
        p[s[0].lower()] = s[1]
    return p

def get_url_post_params(url):
    us = url.split('POSTSTRING:')
    p = {}
    if len(us) < 2:
        return p

    uss = us[1].split('httpcode:')
    usss = uss[0].strip().split('&')
    for u in usss:
        s = u.split('=')
        p[s[0].lower()] = s[1]
    return p



_num_abc__ = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890'
def check_num_abc__(str):
    for c in str:
        if c not in _num_abc__:
            return False
    return True

_num_abc_port_ = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_.1234567890'
def check_num_abc_port__(str):
    for c in str:
        if c not in _num_abc_port_:
            return False
    return True
    
_num = '1234567890'
def check_num(str):
    for c in str:
        if c not in _num:
            return False
    return True


######################################  tornado json begin(由于不支持datetime类型，因此改造) #######################################

try:
    import json
    _json_decode = json.loads
    _json_encode = json.dumps
except Exception:
    try:
        import simplejson
        _json_decode = lambda s: simplejson.loads(_unicode(s))
        _json_encode = lambda v: simplejson.dumps(v)
    except ImportError:
        try:
            # For Google AppEngine
            from django.utils import simplejson
            _json_decode = lambda s: simplejson.loads(_unicode(s))
            _json_encode = lambda v: simplejson.dumps(v)
        except ImportError:
            def _json_decode(s):
                raise NotImplementedError(
                    "A JSON parser is required, e.g., simplejson at "
                    "http://pypi.python.org/pypi/simplejson/")
            _json_encode = _json_decode

def _defaultjson(obj):
    if isinstance(obj, datetime):
        return obj.strftime('%Y-%m-%d %H:%M:%S')
    elif isinstance(obj, date):
        return obj.strftime('%Y-%m-%d')
    else:
        raise TypeError('%r is not JSON serializable' % obj)


def json_encode(value):
    """JSON-encodes the given Python object."""
    # JSON permits but does not require forward slashes to be escaped.
    # This is useful when json data is emitted in a <script> tag
    # in HTML, as it prevents </script> tags from prematurely terminating
    # the javscript.  Some json libraries do this escaping by default,
    # although python's standard library does not, so we do it here.
    # http://stackoverflow.com/questions/1580647/json-why-are-forward-slashes-escaped
    return _json_encode(recursive_unicode(value), default=_defaultjson).replace("</", "<\\/")


def json_decode(value):
    """Returns Python objects for the given JSON string."""
    return _json_decode(to_basestring(value))

_TO_UNICODE_TYPES = (unicode, type(None))
def to_unicode(value):
    """Converts a string argument to a unicode string.

    If the argument is already a unicode string or None, it is returned
    unchanged.  Otherwise it must be a byte string and is decoded as utf8.
    """
    if isinstance(value, _TO_UNICODE_TYPES):
        return value
    assert isinstance(value, bytes)
    return value.decode("utf-8")

_BASESTRING_TYPES = (basestring, type(None))
def to_basestring(value):
    """Converts a string argument to a subclass of basestring.

    In python2, byte and unicode strings are mostly interchangeable,
    so functions that deal with a user-supplied argument in combination
    with ascii string constants can use either and should return the type
    the user supplied.  In python3, the two types are not interchangeable,
    so this method is needed to convert byte strings to unicode.
    """
    if isinstance(value, _BASESTRING_TYPES):
        return value
    return value.decode("utf-8")

def recursive_unicode(obj):
    """Walks a simple data structure, converting byte strings to unicode.

    Supports lists, tuples, and dictionaries.
    """
    if isinstance(obj, dict):
        return dict((recursive_unicode(k), recursive_unicode(v)) for (k, v) in obj.iteritems())
    elif isinstance(obj, list):
        return list(recursive_unicode(i) for i in obj)
    elif isinstance(obj, tuple):
        return tuple(recursive_unicode(i) for i in obj)
    elif isinstance(obj, bytes):
        return to_unicode(obj)
    else:
        return obj

######################################  tornado json end #######################################


if __name__ == '__main__':
    print str_md5('contentid=94&priceid=123&productid=123&userid=123&time=20111020135535&F049460BEA894E138BE970B3D635C9DE')
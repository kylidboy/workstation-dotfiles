function proxy 
  if not set -q $argv 
    set -gx HTTP_PROXY 127.0.0.1:8118
    set -gx HTTPS_PROXY 127.0.0.1:8118
    return
  end
  if test $argv[1] = "off" 
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    return
  end
end


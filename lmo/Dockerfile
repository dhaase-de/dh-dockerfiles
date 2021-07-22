FROM php:5-apache

# create php.ini
COPY php.ini /usr/local/etc/php/

# install LMO
COPY LMO4_0_2a/ /var/www/html/
COPY LMO4_0_2a/install /var/www/html/
COPY init-parameters.php /var/www/html/config
RUN chmod 777 \
    ligen \
    output \
    config \
    ligen/dfb \
    config/viewer \
    addon/tipp/tipps \
    addon/tipp/tipps/auswert \
    addon/tipp/tipps/einsicht \
    addon/tipp/tipps/auswert/vereine \
    addon/spieler/stats
RUN chmod 666 \
    config/cfg.txt \
    config/lmo-auth.php \
    config/tipp/cfg.txt \
    config/spieler/cfg.txt \
    config/ticker/cfg.txt \
    config/mini/cfg.txt \
    config/classlib/cfg.txt \
    config/wap/cfg.txt \
    addon/tipp/lmo-tippauth.txt \
    ligen/bl_2011-12.l98 \
    ligen/.htaccess
RUN chmod 000 /var/www/html/install

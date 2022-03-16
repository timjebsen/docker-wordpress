FROM wordpress:latest

ARG SMTP_SERVER
ARG AUTH_USER
ARG AUTH_PASS

RUN apt-get update
RUN apt-get install -y ssmtp
RUN apt-get clean
RUN SMTP_SERVER=$SMTP_SERVER \
	AUTH_USER=$AUTH_USER \
	AUTH_PASS=$AUTH_PASS \
	echo "mailhub=${SMTP_SERVER}\nAuthUser=${AUTH_USER}\nAuthPass=${AUTH_PASS}\nUseSTARTTLS=YES\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf
RUN cat /etc/ssmtp/ssmtp.conf

RUN echo 'sendmail_path = "/usr/sbin/ssmtp -t -i"' > /usr/local/etc/php/conf.d/mail.in

CMD ["apache2-foreground"]

sysconfdir=/etc
configdir=$(sysconfdir)/local
configmode=700
unitmode=444
unitdir=$(sysconfdir)/systemd/system

SOURCE_UNITS = \
	containers.target \
	devpi.service \
	podman-network@.service \
	postgres.service \
	traefik.service

INSTALLED_UNITS = $(patsubst %,$(unitdir)/%,$(SOURCE_UNITS))

$(unitdir)/%: %
	install -m $(unitmode) $< $@

all:

install: $(INSTALLED_UNITS) $(configdir) $(unitdir)
	systemctl daemon-reload

$(configdir):
	install -d -m $(configmode) $(configdir)

$(unitdir):
	install -d -m 755 $(unitdir)

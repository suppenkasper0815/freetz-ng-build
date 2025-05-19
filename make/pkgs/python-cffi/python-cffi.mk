$(call PKG_INIT_BIN,1.15.1)
$(PKG)_SOURCE:=cffi-$($(PKG)_VERSION).tar.gz
$(PKG)_SITE:=https://files.pythonhosted.org/packages/source/c/cffi
$(PKG)_HASH:=d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9
### WEBSITE:=https://cffi.readthedocs.io
### MANPAGE:=https://cffi.readthedocs.io/en/stable/overview.html
### CHANGES:=https://github.com/python-cffi/cffi/releases
### CVSREPO:=https://github.com/python-cffi/cffi

$(PKG)_TARGET_BINARY:=$($(PKG)_DEST_DIR)$(PYTHON_SITE_PKG_DIR)/_cffi_backend.so

$(PKG)_DEPENDS_ON += python gmp

$(PKG)_REBUILD_SUBOPTS += FREETZ_PACKAGE_PYTHON_STATIC

$(PKG_SOURCE_DOWNLOAD)
$(PKG_UNPACKED)
$(PKG_CONFIGURED_NOP)

$($(PKG)_TARGET_BINARY): $($(PKG)_DIR)/.configured
	$(HOST_TOOLS_DIR)/usr/bin/python2 -m ensurepip || true
	$(HOST_TOOLS_DIR)/usr/bin/python2 -m pip install --no-cache-dir setuptools
	$(call Build/PyMod/PKG, PYTHON_CFFI, , CFLAGS="$(TARGET_CFLAGS) -I$(TARGET_TOOLCHAIN_STAGING_DIR)/include/python2.7" CPPFLAGS="$(TARGET_CFLAGS) -I$(TARGET_TOOLCHAIN_STAGING_DIR)/include/python2.7" PYTHON_INCDIR="$(TARGET_TOOLCHAIN_STAGING_DIR)/include/python2.7" TARGET_ARCH_BE="$(TARGET_ARCH_BE)" PYTHONHOME=$(HOST_TOOLS_DIR)/usr)
	touch -c $@

$(pkg):

$(pkg)-precompiled: $($(PKG)_TARGET_BINARY)

$(pkg)-clean:
	$(RM) -r $(PYTHON_CFFI_DIR)/build

$(pkg)-uninstall:
	$(RM) -r \
		$(PYTHON_CFFI_DEST_DIR)$(PYTHON_SITE_PKG_DIR)/cffi \
		$(PYTHON_CFFI_DEST_DIR)$(PYTHON_SITE_PKG_DIR)/_cffi_backend.so \
		$(PYTHON_CFFI_DEST_DIR)$(PYTHON_SITE_PKG_DIR)/cffi-*.egg-info

$(PKG_FINISH)

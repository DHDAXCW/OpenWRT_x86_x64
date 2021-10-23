sed -i "s/CONFIG_TARGET_ARCH_PACKAGES=\"aarch64_cortex-a53\"/CONFIG_TARGET_ARCH_PACKAGES=\"aarch64_cortex-a72\"/" .config
sed -i "s/CONFIG_DEFAULT_TARGET_OPTIMIZATION=\"-Os -pipe -mcpu=cortex-a53\"/CONFIG_DEFAULT_TARGET_OPTIMIZATION=\"-O3 -pipe -march=armv8-a+crypto+crc -mcpu=cortex-a72.cortex-a53+crypto+crc -mtune=cortex-a72.cortex-a53\"/" .config
sed -i "s/CONFIG_CPU_TYPE=\"cortex-a53\"/CONFIG_CPU_TYPE=\"cortex-a72.cortex-a53\"/" .config
sed -i "s/CONFIG_TARGET_OPTIMIZATION=\"-Os -pipe -mcpu=cortex-a53\"/CONFIG_TARGET_OPTIMIZATION=\"-O3 -pipe -march=armv8-a+crypto+crc -mcpu=cortex-a72.cortex-a53+crypto+crc -mtune=cortex-a72.cortex-a53\"/" .config

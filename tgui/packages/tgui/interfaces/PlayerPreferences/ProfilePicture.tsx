import { ByondUi } from 'tgui-core/components';

import { useBackend } from '../../backend';

export const ProfilePicture = (props) => {
  const { data } = useBackend<ProfilePictureData>();
  const { mapRef } = data;
  const { width = '240px', height = '240px' } = props;
  return (
    <ByondUi
      width={width}
      height={height}
      params={{
        id: mapRef,
        type: 'map',
      }}
    />
  );
};

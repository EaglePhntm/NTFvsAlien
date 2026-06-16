import {
  Button,
  Dropdown,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

interface InputData {
  cockState: string;
  assState: string;
  boobState: string;
  vaginaState: string;
  bellyState: string;
  testicleState: string;
  assSize: number;
  boobSize: string;
  cockSize: number;
  bellySize: number;
  testicleSize: number;
  possibleCockStates: string[];
  possibleAssStates: string[];
  possibleBoobStates: string[];
  possibleVaginaStates: string[];
  possibleBellyStates: string[];
  possibleTesticleStates: string[];
  possibleBoobSizes: string[];
}

export const GenitalMenu = (props: any, context: any) => {
  const { act, data } = useBackend<InputData>();
  const {
    cockState,
    assState,
    boobState,
    vaginaState,
    bellyState,
    testicleState,
    assSize,
    boobSize,
    cockSize,
    bellySize,
    testicleSize,
    possibleCockStates,
    possibleAssStates,
    possibleBoobStates,
    possibleVaginaStates,
    possibleBellyStates,
    possibleTesticleStates,
    possibleBoobSizes,
  } = data;

  return (
    <Window title="Genital selection" width={330} height={470}>
      <Window.Content />
      <Section>
        <Stack fill vertical>
          <Stack.Item>
            <LabeledList>
              <LabeledList.Item label="Genitalia">
                <Dropdown
                  options={possibleCockStates}
                  selected={cockState ? cockState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeCock', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Butt">
                <Dropdown
                  options={possibleAssStates}
                  selected={assState ? assState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeAss', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Butt Size">
                <NumberInput
                  value={assSize}
                  minValue={1}
                  maxValue={8}
                  step={1}
                  width="64px"
                  onChange={(value) =>
                    act('changeSize', {
                      field: 'ass',
                      newSize: value,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Boobs">
                <Dropdown
                  options={possibleBoobStates}
                  selected={boobState ? boobState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeBoobs', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Boob Size">
                <Dropdown
                  options={possibleBoobSizes}
                  selected={boobSize}
                  onSelected={(e: string) =>
                    act('changeSize', {
                      field: 'boobs',
                      newSize: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Vagina">
                <Dropdown
                  options={possibleVaginaStates}
                  selected={vaginaState ? vaginaState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeVagina', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Testicles">
                <Dropdown
                  options={possibleTesticleStates}
                  selected={testicleState ? testicleState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeTesticles', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Testicle Size">
                <NumberInput
                  value={testicleSize}
                  minValue={0}
                  maxValue={8}
                  step={1}
                  width="64px"
                  onChange={(value) =>
                    act('changeSize', {
                      field: 'testicles',
                      newSize: value,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Belly">
                <Dropdown
                  options={possibleBellyStates}
                  selected={bellyState ? bellyState : 'Default'}
                  onSelected={(e: string) =>
                    act('changeBelly', {
                      newState: e,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Belly Size">
                <NumberInput
                  value={bellySize}
                  minValue={0}
                  maxValue={10}
                  step={1}
                  width="64px"
                  onChange={(value) =>
                    act('changeSize', {
                      field: 'belly',
                      newSize: value,
                    })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label="Penis Size">
                <NumberInput
                  value={cockSize}
                  minValue={1}
                  maxValue={7}
                  step={1}
                  width="64px"
                  onChange={(value) =>
                    act('changeSize', {
                      field: 'cock',
                      newSize: value,
                    })
                  }
                />
              </LabeledList.Item>
            </LabeledList>
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              bold
              color="bad"
              icon="ban"
              fontSize={1.25}
              textAlign="center"
              onClick={() => {
                act('reset');
              }}
            >
              Reset to default
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
    </Window>
  );
};

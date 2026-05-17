import { Button, Dropdown, LabeledList, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

interface InputData {
  cockState: string;
  assState: string;
  boobState: string;
  vaginaState: string;
  bellyState: string;
  testicleState: string;
  possibleCockStates: string[];
  possibleAssStates: string[];
  possibleBoobStates: string[];
  possibleVaginaStates: string[];
  possibleBellyStates: string[];
  possibleTesticleStates: string[];
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
    possibleCockStates,
    possibleAssStates,
    possibleBoobStates,
    possibleVaginaStates,
    possibleBellyStates,
    possibleTesticleStates,
  } = data;

  return (
    <Window title="Genital selection" width={300} height={310}>
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

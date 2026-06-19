import {
  Box,
  Button,
  Collapsible,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Skill = {
  name: string;
  base: number;
  current: number;
  color: string;
};

type Data = {
  target_name?: string;
  no_target?: boolean;
  health?: number;
  brute?: number;
  burn?: number;
  toxin?: number;
  clone?: number;
  brain?: number;
  oxy?: number;
  has_disk?: boolean;
  disk_has_data?: boolean;
  disk_name?: string;
  skills?: Skill[];
  logs?: LogEntry[];
};

type SkillChange = {
  skill: string;
  from: number;
  to: number;
  direction: 'up' | 'down';
};

type LogEntry = {
  text: string;
  type: 'extract' | 'imprint';
  changes: SkillChange[];
};

const DamageTile = ({ label, value, color }: { label: string; value: number; color: string }) => (
  <Box
    width="92px"
    textAlign="center"
    p={1.5}
    style={{
      background: '#11151c',
      border: `2px solid ${color}`,
      borderRadius: '4px',
      boxShadow: `0 0 6px ${color}44`,
    }}
  >
    <Box bold color={color} fontSize="11px" mb={0.5} style={{ textTransform: 'uppercase' }}>
      {label}
    </Box>
    <Box fontSize="28px" fontWeight={700} color={color}>
      {value}
    </Box>
  </Box>
);

const SkillBar = ({ skill }: { skill: Skill }) => {
  const formatSkillName = (name: string) => {
    return name
      .replace(/_/g, ' ')
      .split(' ')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
  };

  return (
    <Box
      mb={1}
      p={1.5}
      style={{
        background: 'rgba(42, 42, 42, 0.5)',
        borderRadius: '4px',
        borderLeft: `4px solid #d4af37`,
      }}
    >
      <Stack align="center">
        <Stack.Item grow>
          <Box bold color="#ffffff" fontSize="14px" style={{ textTransform: 'uppercase' }}>
            {formatSkillName(skill.name)}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <ProgressBar
            value={skill.current / 5}
            color={skill.current > skill.base ? 'good' : skill.current < skill.base ? 'bad' : 'average'}
            width="170px"
          >
            {skill.current}
          </ProgressBar>
        </Stack.Item>
      </Stack>
    </Box>
  );
};

export const NeuralStationConsole = () => {
  const { act, data } = useBackend<Data>();

  if (data.no_target) {
    return (
      <Window width={820} height={760} theme="kaizoku">
        <Window.Content>
          <NoticeBox color="orange" textAlign="center" fontSize="18px" bold>
            <Box as="span" color="#ffffff">No neural subject detected</Box>
          </NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  const sortedSkills = [...(data.skills || [])].sort((a, b) => b.current - a.current);

  return (
    <Window width={820} height={760} theme="kaizoku">
      <Window.Content scrollable>
        <Section
          title="KZ Neural Harvesting System"
          buttons={
            <Box color="#d4af37" bold fontSize="13px">
              Covert Division • NS-92
            </Box>
          }
        >
          <NoticeBox color="orange">
            <Box as="span" bold color="#ffffff">Subject: {data.target_name}</Box>
          </NoticeBox>
        </Section>

        <Section title="Subject Status">
          <LabeledList>
            <LabeledList.Item label="Health">
              <ProgressBar
                value={(data.health || 0) / 100}
                ranges={{
                  good: [0.75, Infinity],
                  average: [0.45, 0.75],
                  bad: [-Infinity, 0.45],
                }}
              >
                {data.health}%
              </ProgressBar>
            </LabeledList.Item>

            <LabeledList.Item label="NS-92 Neurodisk">
              {data.has_disk
                ? data.disk_has_data
                  ? <Box color="#d4af37" bold>Encoded — {data.disk_name}</Box>
                  : <Box color="#888">Inserted (Empty)</Box>
                : <Box color="#888">Not Inserted</Box>}
            </LabeledList.Item>
          </LabeledList>
        </Section>

        <Section title="Damage">
          <Stack fill justify="space-between" wrap>
            <DamageTile label="Brute" value={data.brute || 0} color="#ff3333" />
            <DamageTile label="Burn" value={data.burn || 0} color="#ff9900" />
            <DamageTile label="Toxin" value={data.toxin || 0} color="#00ff44" />
            <DamageTile label="Clone" value={data.clone || 0} color="#00ffff" />
            <DamageTile label="Brain" value={data.brain || 0} color="#cc77ff" />
            <DamageTile label="Oxy" value={data.oxy || 0} color="#4488ff" />
          </Stack>
        </Section>

        <Section title="Neural Skills" color="#d4af37">
          <Stack vertical>
            {sortedSkills.map((skill) => (
              <Stack.Item key={`skill-${skill.name}`}>
                <SkillBar skill={skill} />
              </Stack.Item>
            ))}
          </Stack>
        </Section>

        <Section
          title="Neural Operations"
          buttons={
            <>
              <Button
                icon="download"
                color="yellow"
                disabled={!data.has_disk || data.disk_has_data}
                onClick={() => act('extract')}
              >
                Extract
              </Button>
              <Button
                icon="upload"
                color="yellow"
                disabled={!data.disk_has_data}
                onClick={() => act('imprint')}
              >
                Imprint
              </Button>
              <Button
                icon="eject"
                color="yellow"
                disabled={!data.has_disk}
                onClick={() => act('eject_disk')}
              >
                Eject Disk
              </Button>
            </>
          }
        />

        <Section title="Activity Log">
          <Box
            style={{
              background: '#0a0c11',
              border: '1px solid #d4af3722',
              borderRadius: '4px',
              maxHeight: '210px',
              overflowY: 'auto',
              padding: '8px',
            }}
          >
            {(data.logs || []).length === 0 ? (
              <Box color="#555" italic textAlign="center" py={6}>
                Log Buffer Empty
              </Box>
            ) : (
              data.logs?.map((logEntry, entryIndex) => (
                <Collapsible
                  key={entryIndex}
                  title={logEntry.text}
                  color={logEntry.type === 'imprint' ? 'green' : 'red'}
                  style={{
                    background: '#161b22',
                    borderLeft: '3px solid #d4af37',
                    marginBottom: '4px',
                  }}
                >
                  <Box p={1}>
                    {logEntry.changes.map((skillChange, changeIndex) => (
                      <Box key={changeIndex} mb={0.5} fontSize="13px">
                        <Box as="span" style={{ textTransform: 'capitalize' }}>
                          {skillChange.skill}
                        </Box>
                        {': '}
                        <Box as="span" color="label">
                          {skillChange.from}
                        </Box>
                        {' → '}
                        <Box
                          as="span"
                          color={skillChange.direction === 'up' ? 'green' : 'red'}
                          bold
                        >
                          {skillChange.to}
                        </Box>
                      </Box>
                    ))}
                    {(!logEntry.changes || logEntry.changes.length === 0) && (
                      <Box color="gray" italic>
                        No numerical changes
                      </Box>
                    )}
                  </Box>
                </Collapsible>
              ))
            )}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};

export default NeuralStationConsole;
